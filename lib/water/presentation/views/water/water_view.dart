import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/themes.dart';
import '../../controllers/water_controller.dart';
import '../../utils/dialogs.dart';
import '../../widgets/gradient_container.dart';
import '../../widgets/timer.dart';
import 'water_container_widget.dart';

class WaterView extends StatelessWidget {
  const WaterView({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Colors.transparent,
          const Color(0xff5389C0).withOpacity(0.22),
        ],
      ),
      child: Consumer<WaterController>(
        builder: (context, controller, _) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: Spacing.medium2),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Spacing.medium, horizontal: Spacing.normal),
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${controller.waterData.drankToday} ml',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: MyColors.lightGrey1,
                                ),
                              ),
                              Text(
                                '${(controller.waterData.drankTodayPercentage * 100).toInt()}%',
                                style: const TextStyle(
                                  color: MyColors.lightBlue,
                                  fontSize: FontSize.small,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.52,
                            height: MediaQuery.of(context).size.width * 0.52,
                            child: const CircularProgressIndicator(
                              color: MyColors.darkBlue1,
                              value: 1,
                              strokeWidth: Spacing.small1,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.width * 0.6,
                            child: CircularProgressIndicator(
                              value: controller.waterData.drankTodayPercentage,
                              strokeWidth: Spacing.small1,
                              color: controller.waterData.drankTodayPercentage > 1
                                  ? const Color.fromARGB(255, 158, 206, 255)
                                  : MyColors.lightBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: Spacing.medium2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Spacing.small3),
                    child: Column(
                      children: [
                        _InfoBar(
                          icon: const Icon(
                            CupertinoIcons.pin_fill,
                            color: Color(0xff576C82),
                            size: Spacing.normal,
                          ),
                          leftText: 'Meta diária',
                          rightText: Text('${controller.waterData.dailyGoal} ml',
                              style: const TextStyle(color: MyColors.lightBlue)),
                        ),
                        const SizedBox(height: Spacing.small1),
                        _InfoBar(
                          icon: const Icon(
                            CupertinoIcons.drop_fill,
                            color: Color(0xff576C82),
                            size: Spacing.normal,
                          ),
                          leftText: 'Água bebida hoje',
                          rightText: Text('${controller.waterData.drankToday} ml',
                              style: const TextStyle(color: MyColors.lightBlue)),
                        ),
                        const SizedBox(height: Spacing.small1),
                        _InfoBar(
                          icon: const Icon(
                            Icons.timer,
                            color: Color(0xff7E9BBA),
                            size: Spacing.normal,
                          ),
                          backgroundColor: const Color(0xff233444),
                          leftText: 'Beber novamente em',
                          rightText: TimerWidget(stream: controller.startTimerToDrink()),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: Spacing.medium),
                  SizedBox(
                      width: double.infinity,
                      child: WaterContainerWidget(
                        onContainerTap: (amount) async {
                          if (amount > 3500) {
                            return await Dialogs.confirm(
                              title: 'Adicionar quantidade?',
                              text: 'Este recipiente excede 3500 ml',
                              onYes: () => controller.addDrankToday(amount: amount, context: context),
                              onNo: () => Navigator.pop(context),
                              cancelText: 'Cancelar',
                              confirmText: 'Sim, adicionar',
                              context: context,
                            );
                          }

                          controller.addDrankToday(amount: amount, context: context);
                        },
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _InfoBar extends StatelessWidget {
  final Color backgroundColor;
  final String leftText;
  final Widget rightText;
  final Icon icon;

  const _InfoBar({
    this.backgroundColor = const Color(0xff121B23),
    required this.leftText,
    required this.rightText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(Sizes.borderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Spacing.small1, horizontal: Spacing.small2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon,
                const SizedBox(width: Spacing.small2),
                Text(
                  leftText,
                  softWrap: true,
                  style: const TextStyle(color: MyColors.lightGrey),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            rightText,
          ],
        ),
      ),
    );
  }
}
