// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../core/theme/themes.dart';
import '../../../domain/entities/water_container_entity.dart';
import '../../controllers/water_container_controller.dart';
import '../../controllers/water_controller.dart';
import '../../utils/bottom_sheets.dart';
import '../../utils/dialogs.dart';
import '../../widgets/buttons/button.dart';
import '../../widgets/buttons/circular_button.dart';
import '../../widgets/my_text_fields.dart';
import '../../widgets/svg_picker/svg_picker_field.dart';

class WaterContainerComponent extends StatefulWidget {
  final void Function(int amount) onContainerTap;

  const WaterContainerComponent({
    Key? key,
    required this.onContainerTap,
  }) : super(key: key);

  @override
  State<WaterContainerComponent> createState() => _WaterContainerComponentState();
}

class _WaterContainerComponentState extends State<WaterContainerComponent> {
  final _moreOptionsKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    context.read<WaterContainerController>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WaterContainerController>(
      builder: (context, controller, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.small3),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xff141c22), width: 2),
              borderRadius: BorderRadius.circular(Sizes.borderRadius),
            ),
            padding: const EdgeInsets.symmetric(vertical: Spacing.small3),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .1,
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  ListView.builder(
                    itemCount: controller.waterContainers.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      final globalKey = GlobalKey();

                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(width: Spacing.small3),
                          _ContainerButton(
                            key: globalKey,
                            container: controller.waterContainers[i],
                            onLongPress: () {
                              BottomSheets.items(
                                items: [
                                  BottomSheetItemTileSimple(
                                    onTap: () async {
                                      await context.read<WaterController>().removeDrankToday(
                                            amount: controller.waterContainers[i].amount,
                                            context: context,
                                          );

                                      Navigator.pop(context);
                                    },
                                    label: 'Remover água bebida',
                                    icon: const Icon(CommunityMaterialIcons.water_minus_outline),
                                  ),
                                  BottomSheetItemTileCustomChild(
                                    child: InkWell(
                                      onTap: () async {
                                        await controller.remove(
                                          context: context,
                                          waterContainerEntity: controller.waterContainers[i],
                                        );

                                        Navigator.pop(context);
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                          right: Spacing.small3,
                                          left: Spacing.normal - 1.5,
                                          bottom: Spacing.small2,
                                          top: Spacing.small2,
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(CupertinoIcons.delete, size: Spacing.normal + 1),
                                            SizedBox(width: Spacing.small1 + 0.941),
                                            Text('Excluir recipiente'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                context: context,
                              );
                            },
                            onTap: () {
                              widget.onContainerTap(controller.waterContainers[i].amount);
                            },
                          ),
                          if (controller.waterContainers.length - 1 == i) const SizedBox(width: 90)
                        ],
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.only(
                        bottom: Spacing.small2,
                        right: Spacing.small2,
                        left: Spacing.small1,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: Spacing.small,
                            spreadRadius: Spacing.small,
                            offset: Offset(
                              -Spacing.small,
                              0,
                            ),
                          ),
                        ],
                      ),
                      child: CircularButton(
                        contentPadding: const EdgeInsets.all(Spacing.small3),
                        backgroundColor: MyColors.darkGrey,
                        key: _moreOptionsKey,
                        onTap: () {
                          BottomSheets.items(
                            items: [
                              _getAddWaterContainerItemTile(context),
                              _getAddCustomAmount(context),
                              _getRemoveCustomAmount(context),
                              _getReloadContainers(context),
                            ],
                            context: context,
                          );
                        },
                        child: const Icon(CupertinoIcons.ellipsis_vertical),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

BottomSheetItemTile _getAddWaterContainerItemTile(BuildContext context) {
  return BottomSheetItemTileSimple(
    onTap: () {
      Navigator.pop(context);

      final formKey = GlobalKey<FormState>();
      String? assetName;
      int? amount;

      BottomSheets.normal(
        context: context,
        title: 'Criar novo recipiente',
        content: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.small2,
              vertical: Spacing.medium,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPickerField(
                  svgs: CONTAINER_ASSETS,
                  onOk: (value) {
                    assetName = value!;
                  },
                ),
                const SizedBox(height: Spacing.small1),
                DigitOnlyTextField(
                  suffix: 'ml',
                  label: 'Tamanho',
                  autofocus: true,
                  onChanged: (value) {
                    amount = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira um tamanho.';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: Spacing.small2),
                Button.ok(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<WaterContainerController>().add(
                            WaterContainerEntity(
                              assetName: assetName!,
                              amount: amount!,
                            ),
                          );

                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
    icon: const Icon(CommunityMaterialIcons.shape_polygon_plus),
    label: 'Criar novo recipiente',
  );
}

BottomSheetItemTile _getRemoveCustomAmount(BuildContext context) {
  return BottomSheetItemTileSimple(
    onTap: () {
      Navigator.pop(context);

      final formKey = GlobalKey<FormState>();
      int? amount;

      BottomSheets.normal(
        context: context,
        title: 'Remover quantidade customizada',
        content: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.small2,
              vertical: Spacing.medium,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DigitOnlyTextField(
                  suffix: 'ml',
                  label: 'Quantidade',
                  autofocus: true,
                  onChanged: (value) {
                    amount = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira uma quantidade.';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: Spacing.small2),
                Button.ok(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await context.read<WaterController>().removeDrankToday(
                            context: context,
                            amount: amount!,
                          );

                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
    icon: const Icon(CommunityMaterialIcons.water_minus_outline),
    label: 'Remover quantidade customizada',
  );
}

BottomSheetItemTile _getAddCustomAmount(BuildContext context) {
  return BottomSheetItemTileSimple(
    onTap: () {
      Navigator.pop(context);

      final formKey = GlobalKey<FormState>();
      int? amount;

      BottomSheets.normal(
        context: context,
        title: 'Adicionar quantidade customizada',
        content: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.small2,
              vertical: Spacing.medium,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DigitOnlyTextField(
                  suffix: 'ml',
                  label: 'Quantidade',
                  autofocus: true,
                  onChanged: (value) {
                    amount = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira uma quantidade.';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: Spacing.small2),
                Button.ok(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      if (amount! >= 3500) {
                        await Dialogs.confirm(
                            title: 'Adicionar quantidade?',
                            text: 'Esta quantidade excede 3500 ml',
                            cancelText: 'Cancelar',
                            confirmText: 'Sim, adicionar',
                            context: context,
                            onYes: () async {
                              await context.read<WaterController>().addDrankToday(
                                    amount: amount!,
                                    context: context,
                                  );

                              Navigator.popUntil(context, ModalRoute.withName('/home'));
                            },
                            onNo: () {
                              Navigator.pop(context);
                            });
                      } else {
                        await context.read<WaterController>().addDrankToday(
                              amount: amount!,
                              context: context,
                            );

                        Navigator.pop(context);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
    icon: const Icon(CommunityMaterialIcons.water_plus_outline),
    label: 'Adicionar quantidade customizada',
  );
}

BottomSheetItemTile _getReloadContainers(BuildContext context) {
  return BottomSheetItemTileSimple(
    onTap: () async {
      Navigator.pop(context);
      await Dialogs.confirm(
        title: 'Recarregar recipientes?',
        text: 'Todos recipientes serão excluídos e recarregados.',
        context: context,
        confirmText: 'Sim, recarregar',
        cancelText: 'Cancelar',
        onNo: () {
          Navigator.pop(context);
        },
        onYes: () async {
          await context.read<WaterContainerController>().reload();
          Navigator.pop(context);
        },
      );
    },
    icon: const Icon(CommunityMaterialIcons.restart),
    label: 'Recarregar recipientes',
  );
}

class _ContainerButton extends StatelessWidget {
  final WaterContainerEntity container;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _ContainerButton({
    super.key,
    required this.container,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return CircularButton(
      onTap: () => onTap(),
      onLongPress: () => onLongPress(),
      label: container.amount <= 999
          ? Text(
              '${container.amount} ml',
              style: const TextStyle(color: MyColors.lightGrey, fontWeight: FontWeight.w500),
            )
          : Text(
              '${NumberFormat.decimalPattern('pt_BR').format(container.amount / 1000)}l',
              style: const TextStyle(color: MyColors.lightGrey, fontWeight: FontWeight.w500),
            ),
      child: SvgPicture.asset(
        'assets/images/${container.assetName}',
        height: Spacing.medium1,
        width: Spacing.medium1,
      ),
    );
  }
}
