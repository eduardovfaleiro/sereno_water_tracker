import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/themes.dart';
import '../../../domain/entities/water_container_entity.dart';
import '../../controllers/water_controller.dart';
import '../../widgets/buttons/circular_button.dart';
import '../../widgets/gradient_container.dart';
import '../../widgets/timer.dart';

class WaterView extends StatelessWidget {
  WaterView({super.key});

  final _moreOptionsKey = GlobalKey();

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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Consumer<WaterController>(
          builder: (context, controller, _) {
            if (controller.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Spacing.normal),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: Spacing.huge6),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: Spacing.medium),
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
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: Spacing.medium2),
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
                      const SizedBox(height: Spacing.medium),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xff233444).withOpacity(0.5), width: 2),
                          borderRadius: BorderRadius.circular(Sizes.borderRadius),
                        ),
                        padding: const EdgeInsets.all(Spacing.normal),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: List.generate(controller.waterContainers.length, (i) {
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          _ContainerButton(
                                            container: controller.waterContainers[i],
                                            onTap: () {
                                              controller.addDrankToday(
                                                amount: controller.waterContainers[i].amount,
                                                context: context,
                                              );
                                            },
                                          ),
                                          if (controller.waterContainers.length != i) const SizedBox(width: 16)
                                        ],
                                      );
                                    }),
                                  ),
                                ),
                              ),
                              CircularButton(
                                backgroundColor: MyColors.darkBlue,
                                key: _moreOptionsKey,
                                onTap: () {},
                                child: const Icon(CupertinoIcons.ellipsis_vertical),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
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
              children: [
                icon,
                const SizedBox(width: Spacing.small2),
                Text(leftText, style: const TextStyle(color: MyColors.lightGrey))
              ],
            ),
            rightText,
          ],
        ),
      ),
    );
  }
}

class _ContainerButton extends StatelessWidget {
  final WaterContainerEntity container;
  final VoidCallback onTap;

  const _ContainerButton({
    required this.container,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CircularButton(
      onTap: () => onTap(),
      label: Text(
        '${container.amount}ml',
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
