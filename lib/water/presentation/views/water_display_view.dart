import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../core/theme/themes.dart';
import '../utils/menus.dart';
import '../view_models/water_view_model.dart';
import '../widgets/circular_button.dart';

class WaterDisplayView extends StatelessWidget {
  WaterDisplayView({super.key});

  final _moreOptionsGlobalKey = GlobalKey();

  final _moreOptionsItems = <PopupMenuEntry>[
    PopupMenuItem(
      onTap: () {},
      child: const Row(
        children: [
          Icon(CommunityMaterialIcons.shape_polygon_plus, color: MyColors.lightGrey),
          SizedBox(width: Spacing.small2),
          Text('Add new container'),
        ],
      ),
    ),
    const PopupMenuItem(
      child: Row(
        children: [
          Icon(CommunityMaterialIcons.water_plus_outline, color: MyColors.lightGrey),
          SizedBox(width: Spacing.small2),
          Text('Add specific amount'),
        ],
      ),
    ),
    const PopupMenuItem(
      child: Row(
        children: [
          Icon(CommunityMaterialIcons.water_minus_outline, color: MyColors.lightGrey),
          SizedBox(width: Spacing.small2),
          Text('Remove specific amount'),
        ],
      ),
    ),
  ];

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
                      child: Wrap(
                        spacing: Spacing.small1,
                        children: [
                          const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularButton(
                                color: MyColors.lightGrey,
                                label: Text('+250 $VOLUME_UNIT_M',
                                    style: TextStyle(
                                      color: MyColors.lightGrey,
                                      fontSize: FontSize.small,
                                      fontWeight: FontWeight.w500,
                                    )),
                                child: Icon(CommunityMaterialIcons.cup, color: MyColors.darkGrey),
                              ),
                            ],
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
                                    items: _moreOptionsItems,
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
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
              return const Text('Loading...');
            }

            return snapshot.data!.fold(
              (failure) {
                return const Text('Unavailable');
              },
              (amountOfWaterDrankToday) {
                return Text(
                  '$amountOfWaterDrankToday ml',
                  style: const TextStyle(color: Color(0xFF4E9CC8)),
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

class BackgroundImageWithGradient extends StatelessWidget {
  const BackgroundImageWithGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        const Positioned.fill(
          top: -500,
          child: Image(image: AssetImage('assets/images/water_background.jpg')),
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
