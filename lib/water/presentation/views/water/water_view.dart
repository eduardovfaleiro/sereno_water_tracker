import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/themes.dart';
import '../../controllers/water_controller.dart';
import '../../utils/dialogs.dart';
import '../../utils/snackbar_message.dart';
import '../../widgets/gradient_container.dart';
import 'water_container_component.dart';

class WaterView extends StatefulWidget {
  const WaterView({super.key});

  @override
  State<WaterView> createState() => _WaterViewState();
}

class _WaterViewState extends State<WaterView> {
  @override
  void initState() {
    super.initState();

    context.read<WaterController>().init();
  }

  String _getText({required Duration duration}) {
    if (duration.inSeconds < 60) {
      if (duration.inSeconds == 0) {
        return '';
      }

      if (duration.inSeconds == 1) {
        return '${duration.inSeconds} segundo';
      }

      return '${duration.inSeconds} segundos';
    }

    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

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
                  Container(
                    width: MediaQuery.of(context).size.width,
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
                          rightText: Text(
                            '${controller.waterData.drankToday} ml',
                            style: const TextStyle(color: MyColors.lightBlue),
                            softWrap: true,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: Spacing.small1),
                        _InfoBar(
                          icon: const Icon(
                            Icons.timer,
                            color: MyColors.lightBlue2,
                            size: Spacing.normal,
                          ),
                          backgroundColor: MyColors.darkBlue3,
                          leftText: 'Beber novamente em',
                          rightText: ValueListenableBuilder(
                            valueListenable: controller.timerToDrinkService.timeToDrink,
                            builder: (context, timeToDrink, _) {
                              return Text(
                                _getText(duration: timeToDrink),
                                style: const TextStyle(color: MyColors.lightBlue3),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: Spacing.medium),
                  SizedBox(
                      width: double.infinity,
                      child: WaterContainerComponent(
                        onContainerTap: (amount) async {
                          if (amount > 3500) {
                            await Dialogs.confirm(
                              title: 'Adicionar quantidade?',
                              text: 'Este recipiente excede 3500 ml',
                              onYes: () async {
                                await controller.addDrankToday(amount: amount, context: context);

                                SnackBarMessage.undo(
                                  context: context,
                                  text: '$amount ml adicionado',
                                  onPressed: () async {
                                    controller.removeDrankToday(
                                      amount: amount,
                                      context: context,
                                    );
                                  },
                                );

                                Navigator.pop(context);
                              },
                              onNo: () => Navigator.pop(context),
                              cancelText: 'Cancelar',
                              confirmText: 'Sim, adicionar',
                              context: context,
                            );

                            return;
                          }

                          await controller.addDrankToday(amount: amount, context: context);

                          SnackBarMessage.undo(
                            context: context,
                            text: '$amount ml adicionado',
                            onPressed: () async {
                              controller.removeDrankToday(
                                amount: amount,
                                context: context,
                              );
                            },
                          );
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
    this.backgroundColor = MyColors.darkBlue2,
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
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: rightText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
