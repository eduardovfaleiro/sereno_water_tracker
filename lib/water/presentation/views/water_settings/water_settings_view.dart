// ignore_for_file: unused_element

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../core/functions/time_of_day_utils.dart';
import '../../../../core/theme/themes.dart';
import '../../controllers/water_controller.dart';
import '../../controllers/water_settings_controller.dart';
import '../../utils/dialogs.dart';
import '../../widgets/buttons/button.dart';

class WaterSettingsView extends StatefulWidget {
  const WaterSettingsView({super.key});

  @override
  State<WaterSettingsView> createState() => _WaterSettingsViewState();
}

class _WaterSettingsViewState extends State<WaterSettingsView> {
  @override
  void initState() {
    super.initState();

    context.read<WaterSettingsController>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WaterSettingsController>(
      builder: (context, controller, _) {
        return Scaffold(
          bottomNavigationBar: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.small2,
                vertical: Spacing.small1,
              ),
              child: Button.normal(
                onPressed: () async {
                  await Dialogs.confirm(
                    title: 'Tem certeza?',
                    text: 'A quantidade de água bebida será zerada.',
                    cancelText: 'Cancelar',
                    confirmText: 'Sim, continuar',
                    onYes: () async {
                      controller.saveData();
                      context.read<WaterController>().timerToDrinkService.start();

                      Navigator.pop(context);
                    },
                    onNo: () {
                      Navigator.pop(context);
                    },
                    context: context,
                  );
                },
                text: 'Salvar',
              )),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: Spacing.medium2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Spacing.small),
                    child: _SimpleCard(
                      text: 'Peso',
                      value: '${controller.isLoading ? MIN_WEIGHT : controller.userEntity.weight} kg',
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(height: Spacing.small2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Spacing.small),
                    child: _SimpleCard(
                      text: 'Dias de treino por semana',
                      value: '${controller.isLoading ? 0 : controller.userEntity.weeklyWorkoutDays} dias',
                      onTap: () {},
                    ),
                    // child: Column(
                    //   children: [
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         const Text('Dias de treino por semana'),
                    //         Text('${controller.isLoading ? 0 : controller.userEntity.weeklyWorkoutDays} dias'),
                    //       ],
                    //     ),
                    //     const SizedBox(height: Spacing.small2),
                    //     Slider(
                    //       max: DAYS_IN_A_WEEK.toDouble(),
                    //       value: controller.isLoading ? 0 : controller.userEntity.weeklyWorkoutDays.toDouble(),
                    //       onChanged: (value) {
                    //         controller.setWeeklyWorkoutDays(value.toInt());
                    //       },
                    //     ),
                    //   ],
                    // ),
                  ),
                  const SizedBox(height: Spacing.small2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Spacing.small),
                    child: _SimpleCard(
                      onTap: () {},
                      text: 'Quantas vezes beber por dia',
                      value:
                          '${controller.isLoading ? MIN_DAILY_DRINKING_FREQUENCY : controller.waterDataEntity.dailyDrinkingFrequency} vezes',
                    ),
                    // child: Column(
                    //   children: [
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         const Text('Quantas vezes beber por dia'),
                    //         Text(
                    //           '${controller.isLoading ? MIN_DAILY_DRINKING_FREQUENCY : controller.waterDataEntity.dailyDrinkingFrequency} vezes',
                    //         ),
                    //       ],
                    //     ),
                    //     const SizedBox(height: Spacing.small2),
                    //     Slider(
                    //       min: MIN_DAILY_DRINKING_FREQUENCY.toDouble(),
                    //       max: MAX_DAILY_DRINKING_FREQUENCY.toDouble(),
                    //       value: controller.isLoading
                    //           ? MIN_DAILY_DRINKING_FREQUENCY.toDouble()
                    //           : controller.waterDataEntity.dailyDrinkingFrequency.toDouble(),
                    //       onChanged: (value) {
                    //         controller.setDailyDrinkingFrequency(value.toInt());
                    //       },
                    //     ),
                    //   ],
                    // ),
                  ),
                  const SizedBox(height: Spacing.small2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Spacing.small),
                    child: _SimpleCard(
                      text: 'Hora de acordar',
                      preffixIcon: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: Spacing.small1),
                        child: Icon(CupertinoIcons.sun_max),
                      ),
                      value: TimeOfDayUtils(controller.userEntity.wakeUpTime).toLiteral(),
                      onTap: () {},
                    ),
                    // child: Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //     const Text('Hora de acordar'),
                    //     const SizedBox(height: Spacing.small),
                    //     Container(
                    //       height: MediaQuery.of(context).size.height * 0.2,
                    //       alignment: Alignment.center,
                    //       child: TimePicker(
                    //         icon: CupertinoIcons.sun_max,
                    //         initialTime: controller.isLoading
                    //             ? const TimeOfDay(hour: 0, minute: 0)
                    //             : controller.userEntity.wakeUpTime,
                    //         onHourChanged: (value) {
                    //           controller.setWakeUpTime(value);
                    //         },
                    //         onMinuteChanged: (value) {
                    //           controller.setWakeUpTime(value);
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ),
                  const SizedBox(height: Spacing.small2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Spacing.small),
                    child: _SimpleCard(
                      preffixIcon: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: Spacing.small1),
                        child: Icon(CupertinoIcons.moon),
                      ),
                      text: 'Hora de dormir',
                      value: TimeOfDayUtils(controller.userEntity.sleeptime).toLiteral(),
                      onTap: () {},
                    ),
                    // child: Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //     const Text('Hora de dormir'),
                    //     const SizedBox(height: Spacing.small),
                    //     Container(
                    //       height: MediaQuery.of(context).size.height * 0.2,
                    //       alignment: Alignment.center,
                    //       child: TimePicker(
                    //         initialTime: controller.isLoading
                    //             ? const TimeOfDay(hour: 0, minute: 0)
                    //             : controller.userEntity.sleeptime,
                    //         icon: CupertinoIcons.moon,
                    //         onHourChanged: (value) {
                    //           controller.setSleepTime(value);
                    //         },
                    //         onMinuteChanged: (value) {
                    //           controller.setSleepTime(value);
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // ),
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

class _SimpleCard extends StatelessWidget {
  final String text;
  final String value;
  final Function() onTap;
  final Widget? preffixIcon;

  const _SimpleCard({required this.text, required this.value, required this.onTap, this.preffixIcon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(Sizes.borderRadius),
      child: Ink(
        decoration: BoxDecoration(
          color: MyColors.darkGrey,
          borderRadius: BorderRadius.circular(Sizes.borderRadius),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.small1,
          vertical: Spacing.small3,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      preffixIcon ?? const SizedBox.shrink(),
                      const SizedBox(width: Spacing.small1),
                      Text(text, style: const TextStyle()),
                    ],
                  ),
                  Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.small2),
              child: Icon(CupertinoIcons.pencil, color: MyColors.lightGrey),
            ),
          ],
        ),
      ),
    );
  }
}
