// ignore_for_file: must_be_immutable

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../core/theme/themes.dart';
import '../../domain/entities/water_container_entity.dart';
import '../utils/dialogs.dart';
import '../utils/menus.dart';
import '../utils/snackbar_message.dart';
import '../view_models/water_container_view_model.dart';
import '../view_models/water_view_model.dart';
import '../widgets/button.dart';
import '../widgets/circular_button.dart';
import '../widgets/icon_picker/icon_picker_field.dart';

class WaterDisplayView extends StatelessWidget {
  const WaterDisplayView({super.key});

  // final _moreOptionsItems = <PopupMenuEntry>[
  //   PopupMenuItem(
  //     onTap: () {
  //       showDialog(context: context, builder: builder);
  //     },
  //     child: const Row(
  //       children: [
  //         Icon(CommunityMaterialIcons.shape_polygon_plus, color: MyColors.lightGrey),
  //         SizedBox(width: Spacing.small2),
  //         Text('Add new container'),
  //       ],
  //     ),
  //   ),
  //   const PopupMenuItem(
  //     child: Row(
  //       children: [
  //         Icon(CommunityMaterialIcons.water_plus_outline, color: MyColors.lightGrey),
  //         SizedBox(width: Spacing.small2),
  //         Text('Add specific amount'),
  //       ],
  //     ),
  //   ),
  //   const PopupMenuItem(
  //     child: Row(
  //       children: [
  //         Icon(CommunityMaterialIcons.water_minus_outline, color: MyColors.lightGrey),
  //         SizedBox(width: Spacing.small2),
  //         Text('Remove specific amount'),
  //       ],
  //     ),
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          top: -650,
          child: Image(
            image: AssetImage('assets/images/water_background.png'),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment(0, 0.05),
              colors: [Colors.transparent, Color.fromARGB(255, 0, 0, 0), Color.fromARGB(255, 0, 0, 0)],
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: Container(
            color: Colors.black,
          ),
        ),
        Scaffold(
          body: Consumer<WaterViewModel>(
            builder: (context, waterViewModel, _) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: Spacing.small1,
                  right: Spacing.small1,
                  top: Spacing.huge16,
                  bottom: Spacing.small3,
                ),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(height: Spacing.small3),
                    Container(
                      padding: const EdgeInsets.all(Spacing.normal),
                      decoration: BoxDecoration(
                        color: MyColors.darkGrey,
                        borderRadius: BorderRadius.circular(Sizes.borderRadius),
                      ),
                      child: Column(
                        children: [
                          WaterDataWidget(
                            'Water drank today',
                            waterViewModel.getAmountDrankToday(),
                          ),
                          const SizedBox(height: Spacing.small3),
                          ProgressBar(waterViewModel.getDailyGoalCompletedPercentage()),
                          const SizedBox(height: Spacing.small3),
                          WaterDataWidget('Daily goal', waterViewModel.getDailyDrinkingGoal()),
                        ],
                      ),
                    ),
                    const SizedBox(height: Spacing.small3),
                    Container(
                      padding: const EdgeInsets.all(Spacing.normal),
                      decoration: BoxDecoration(
                        color: MyColors.darkGrey,
                        borderRadius: BorderRadius.circular(Sizes.borderRadius),
                      ),
                      child: const DurationWidget('Drink again in', Duration(hours: 3)),
                    ),
                    const SizedBox(height: Spacing.medium),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: Spacing.normal),
                      alignment: Alignment.topLeft,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: WaterContainerWidget(),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class AddCustomWaterAmountWidget extends StatelessWidget {
  AddCustomWaterAmountWidget({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey();
  final WaterViewModel _waterViewModel = getIt<WaterViewModel>();

  int _amount = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        icon: const Icon(CommunityMaterialIcons.water_plus_outline, size: Spacing.medium2),
        title: const Align(
          child: Text(
            'Add custom amount',
            style: TextStyle(
              fontSize: FontSize.small2,
              fontWeight: FontWeight.w500,
              color: MyColors.lightGrey,
            ),
          ),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  label: Text('Amount'),
                  suffix: Text('ml'),
                ),
                onChanged: (value) {
                  _amount = int.tryParse(value) ?? 0;
                },
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Amount shouldn\'t be empty.';
                  if (value == '0') return 'Amount shouldn\'t be zero.';

                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await _waterViewModel.getAmountDrankToday().then((result) {
                    result.fold((failure) {
                      SnackBarMessage.normal(context: context, text: failure.message);
                    }, (success) async {
                      int amountDrankToday = success;
                      int updatedAmountDrankToday = amountDrankToday + _amount;

                      await _waterViewModel.updateAmountDrankToday(updatedAmountDrankToday).whenComplete(() {
                        Navigator.pop(context);

                        SnackBarMessage.undo(
                            context: context,
                            text: 'Added $_amount ml',
                            onPressed: () async {
                              updatedAmountDrankToday -= _amount;

                              await _waterViewModel.updateAmountDrankToday(updatedAmountDrankToday);
                            });
                      });
                    });
                  });
                }
              },
              child: const Text(
                'OK',
                style: TextStyle(color: MyColors.darkGrey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RemoveCustomWaterAmountWidget extends StatelessWidget {
  RemoveCustomWaterAmountWidget({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey();
  final WaterViewModel waterViewModel = getIt<WaterViewModel>();

  int _amount = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        icon: const Icon(CommunityMaterialIcons.water_minus_outline, size: Spacing.medium2),
        title: const Align(
          child: Text(
            'Remove custom amount',
            style: TextStyle(
              fontSize: FontSize.small2,
              fontWeight: FontWeight.w500,
              color: MyColors.lightGrey,
            ),
          ),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  label: Text('Amount'),
                  suffix: Text('ml'),
                ),
                onChanged: (value) {
                  _amount = int.tryParse(value) ?? 0;
                },
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Amount shouldn\'t be empty.';
                  if (value == '0') return 'Amount shouldn\'t be zero.';

                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await waterViewModel.getAmountDrankToday().then((result) {
                    result.fold((failure) {
                      SnackBarMessage.normal(context: context, text: failure.message);
                    }, (success) async {
                      int amountDrankToday = success;
                      int updatedAmountDrankToday = amountDrankToday - _amount;

                      await waterViewModel.updateAmountDrankToday(updatedAmountDrankToday).whenComplete(() {
                        Navigator.pop(context);

                        SnackBarMessage.undo(
                            context: context,
                            text: 'Removed $_amount ml',
                            onPressed: () async {
                              updatedAmountDrankToday += _amount;

                              await waterViewModel.updateAmountDrankToday(updatedAmountDrankToday);
                            });
                      });
                    });
                  });
                }
              },
              child: const Text(
                'OK',
                style: TextStyle(color: MyColors.darkGrey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CreateWaterContainerWidget extends StatelessWidget {
  CreateWaterContainerWidget({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey();

  int _amount = 0;
  IconData? _selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        icon: const Icon(CommunityMaterialIcons.shape_polygon_plus, size: Spacing.medium2),
        title: const Align(
          child: Text(
            'Add new container',
            style: TextStyle(
              fontSize: FontSize.small2,
              fontWeight: FontWeight.w500,
              color: MyColors.lightGrey,
            ),
          ),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  label: Text('Amount'),
                  suffix: Text('ml'),
                ),
                onChanged: (value) {
                  _amount = int.parse(value);
                },
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Amount shouldn\'t be empty.';
                  if (value == '0') return 'Amount shouldn\'t be zero.';

                  return null;
                },
              ),
              const SizedBox(height: Spacing.small1),
              IconPickerField(onOk: (_) {}, icons: const [
                CommunityMaterialIcons.cup_water,
                CommunityMaterialIcons.bottle_soda_classic,
              ]),
            ],
          ),
        ),
        actions: [
          SizedBox(
              width: double.infinity,
              child: Button.ok(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var waterContainerEntity = WaterContainerEntity(
                      icon: _selectedIcon!,
                      amount: _amount,
                    );

                    await getIt<WaterContainerViewModel>().create(waterContainerEntity).then((value) {
                      Navigator.pop(context);

                      value.fold((failure) {
                        SnackBarMessage.normal(context: context, text: failure.message);
                      }, (success) {
                        SnackBarMessage.undo(context: context, text: 'Container created', onPressed: () {});
                      });
                    });
                  }
                },
              )),
        ],
      ),
    );
  }
}

class WaterDataWidget extends StatelessWidget {
  final String text;
  final Future<Result<int>> value;

  const WaterDataWidget(this.text, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text),
        FutureBuilder(
          future: value,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text(
                'Loading...',
                style: TextStyle(color: MyColors.lightBlue),
              );
            }

            return snapshot.data!.fold(
              (failure) {
                return const Text(
                  'Unavailable',
                  style: TextStyle(color: MyColors.lightBlue),
                );
              },
              (amountOfWaterDrankToday) {
                return Text(
                  '$amountOfWaterDrankToday ml',
                  style: const TextStyle(color: MyColors.lightBlue),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class DurationWidget extends StatelessWidget {
  final String text;
  final Duration value;

  const DurationWidget(this.text, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text),
        const Text(
          '3h 27min',
          style: TextStyle(color: Color(0xFF4E9CC8)),
        ),
      ],
    );
  }
}

class ProgressBar extends StatefulWidget {
  final Future<Result<double>> value;

  const ProgressBar(this.value, {super.key});

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        var percentage = snapshot.data as Result<double>?;

        if (snapshot.data == null) {
          return const LinearProgressIndicator(value: 0);
        }

        return LinearProgressIndicator(
          value: percentage!.fold((failure) => 0, (success) => success),
        );
      },
    );
  }
}

class WaterContainerWidget extends StatelessWidget {
  WaterContainerWidget({super.key});

  final GlobalKey _moreOptionsGlobalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Consumer<WaterContainerViewModel>(
      builder: (context, waterContainerViewModel, _) {
        return FutureBuilder(
          future: waterContainerViewModel.getAllContainers(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            }

            return snapshot.data!.fold((failure) {
              SnackBarMessage.normal(context: context, text: 'Couldn\'t get water containers');
              return const SizedBox();
            }, (success) {
              var waterContainers = success;

              return Wrap(
                spacing: Spacing.small1,
                children: [
                  ...List.generate(
                    waterContainers.length,
                    (index) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularButton(
                            color: MyColors.lightGrey,
                            label: Text(
                              '+${waterContainers[index].amount} $VOLUME_UNIT_M',
                              style: const TextStyle(
                                color: MyColors.lightGrey,
                                fontSize: FontSize.small,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            child: const Icon(CommunityMaterialIcons.cup, color: MyColors.darkGrey),
                          ),
                        ],
                      );
                    },
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircularButton(
                        key: _moreOptionsGlobalKey,
                        color: MyColors.darkGrey,
                        child: const Icon(
                          CommunityMaterialIcons.dots_vertical,
                          color: MyColors.lightGrey,
                        ),
                        onTap: () async {
                          await Menus.normal(
                            key: _moreOptionsGlobalKey,
                            context: context,
                            items: [
                              PopupMenuItem(
                                onTap: () async {
                                  await Future.delayed(Duration.zero, () {
                                    Dialogs.normal(
                                      child: CreateWaterContainerWidget(),
                                      context: context,
                                    );
                                  });
                                },
                                child: const Row(
                                  children: [
                                    Icon(CommunityMaterialIcons.shape_polygon_plus, color: MyColors.lightGrey),
                                    SizedBox(width: Spacing.small2),
                                    Text('Add new container'),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                onTap: () async {
                                  await Future.delayed(Duration.zero, () {
                                    Dialogs.normal(
                                      context: context,
                                      child: AddCustomWaterAmountWidget(),
                                    );
                                  });
                                },
                                child: const Row(
                                  children: [
                                    Icon(CommunityMaterialIcons.water_plus_outline, color: MyColors.lightGrey),
                                    SizedBox(width: Spacing.small2),
                                    Text('Add custom amount'),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                onTap: () async {
                                  await Future.delayed(Duration.zero, () {
                                    Dialogs.normal(
                                      context: context,
                                      child: RemoveCustomWaterAmountWidget(),
                                    );
                                  });
                                },
                                child: const Row(
                                  children: [
                                    Icon(CommunityMaterialIcons.water_minus_outline, color: MyColors.lightGrey),
                                    SizedBox(width: Spacing.small2),
                                    Text('Remove custom amount'),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ],
              );
            });
          },
        );
      },
    );
  }
}
