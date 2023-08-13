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
import '../../utils/bottom_sheets.dart';
import '../../utils/menus.dart';
import '../../widgets/buttons/button.dart';
import '../../widgets/buttons/circular_button.dart';
import '../../widgets/my_text_fields.dart';
import '../../widgets/svg_picker/svg_picker_field.dart';

class WaterContainerWidget extends StatefulWidget {
  final void Function(int amount) onContainerTap;

  const WaterContainerWidget({
    Key? key,
    required this.onContainerTap,
  }) : super(key: key);

  @override
  State<WaterContainerWidget> createState() => _WaterContainerWidgetState();
}

class _WaterContainerWidgetState extends State<WaterContainerWidget> {
  final _moreOptionsKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      await context.read<WaterContainerController>().init();
    });
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
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(width: Spacing.small3),
                          _ContainerButton(
                            container: controller.waterContainers[i],
                            onLongPress: () {},
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
                          Menus.normal(
                            key: _moreOptionsKey,
                            items: [
                              PopupMenuItem(
                                onTap: () {
                                  Future.delayed(Duration.zero, () async {
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
                                              Button.ok(onPressed: () {
                                                if (formKey.currentState!.validate()) {
                                                  controller.add(
                                                    WaterContainerEntity(
                                                      assetName: assetName!,
                                                      amount: amount!,
                                                    ),
                                                  );
                                                }

                                                Navigator.pop(context);
                                              }),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                                },
                                child: const Row(
                                  children: [
                                    Icon(CommunityMaterialIcons.shape_polygon_plus),
                                    SizedBox(width: Spacing.small2),
                                    Text('Criar novo recipiente')
                                  ],
                                ),
                              ),
                              const PopupMenuItem(
                                child: Row(
                                  children: [
                                    Icon(CommunityMaterialIcons.water_plus_outline),
                                    SizedBox(width: Spacing.small2),
                                    Text('Adicionar quantidade customizada')
                                  ],
                                ),
                              ),
                              const PopupMenuItem(
                                child: Row(
                                  children: [
                                    Icon(CommunityMaterialIcons.water_minus_outline),
                                    SizedBox(width: Spacing.small2),
                                    Text('Remover quantidade customizada')
                                  ],
                                ),
                              ),
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

class _ContainerButton extends StatelessWidget {
  final WaterContainerEntity container;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _ContainerButton({
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
              '${container.amount}ml',
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