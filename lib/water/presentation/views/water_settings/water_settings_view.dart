// ignore_for_file: unused_element

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../core/functions/time_of_day_utils.dart';
import '../../../../core/theme/themes.dart';
import '../../controllers/water_controller.dart';
import '../../controllers/water_settings_controller.dart';
import '../../utils/bottom_sheets.dart';
import '../../utils/show_edit_daily_goal.dart';
import '../../utils/show_edit_time.dart';
import '../../utils/snackbar_message.dart';
import '../../widgets/buttons/button.dart';
import '../../widgets/number_picker.dart';

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
          appBar: AppBar(actions: [
            Padding(
              padding: const EdgeInsets.only(right: Spacing.small3),
              child: InkWell(
                borderRadius: BorderRadius.circular(Sizes.borderRadius),
                onTap: () async {
                  await controller.saveData(context).then((_) {
                    SnackBarMessage.normal(context: context, text: 'Dados redefinidos com sucesso');
                  });

                  await controller.init();

                  context.read<WaterController>().timerToDrinkService.start();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.small2, vertical: Spacing.small1),
                  child: Row(
                    children: [
                      Icon(Icons.done, color: MyColors.lightBlue),
                      SizedBox(width: Spacing.small),
                      Text('Salvar', style: TextStyle(color: MyColors.lightBlue)),
                    ],
                  ),
                ),
              ),
            ),
          ]),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Spacing.small3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: Spacing.small3),
                      child: Icon(CupertinoIcons.drop_fill, size: Spacing.medium, color: MyColors.lightBlue2),
                    ),
                    const SizedBox(height: Spacing.small1),
                    _SpecialCard(
                      text: 'Meta diária',
                      value: '${controller.waterDataEntity.dailyGoal} ml',
                      onTap: () {
                        showEditDailyGoalBottomSheet(
                          context: context,
                          onOk: (dailyGoal) {
                            controller.setDailyGoal(dailyGoal);

                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                    const SizedBox(height: Spacing.medium),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: Spacing.small3),
                      child: Icon(CommunityMaterialIcons.weight, size: Spacing.medium, color: MyColors.lightGrey3),
                    ),
                    const SizedBox(height: Spacing.small),
                    _SimpleCard(
                      text: 'Peso',
                      value: '${controller.isLoading ? MIN_WEIGHT : controller.userEntity.weight} kg',
                      onTap: () async {
                        await _showEditWeight(
                          context: context,
                          onOk: (weight) {
                            controller.setWeight(weight);

                            Navigator.pop(context);
                          },
                          weight: controller.userEntity.weight,
                        );
                      },
                    ),
                    const SizedBox(height: Spacing.medium),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: Spacing.small3),
                      child:
                          Icon(CommunityMaterialIcons.weight_lifter, size: Spacing.medium, color: MyColors.lightGrey3),
                    ),
                    const SizedBox(height: Spacing.small),
                    _SimpleCard(
                      text: 'Dias de treino por semana',
                      value: '${controller.isLoading ? 0 : controller.userEntity.weeklyWorkoutDays} dias',
                      onTap: () async {
                        await _showEditWeeklyWorkoutDays(
                          context: context,
                          onOk: (newWeeklyWorkoutDays) {
                            controller.setWeeklyWorkoutDays(newWeeklyWorkoutDays);

                            Navigator.pop(context);
                          },
                          weeklyWorkoutDays: controller.userEntity.weeklyWorkoutDays,
                        );
                      },
                    ),
                    const SizedBox(height: Spacing.medium),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: Spacing.small3),
                      child: Icon(Icons.timer, size: Spacing.medium, color: MyColors.lightGrey3),
                    ),
                    const SizedBox(height: Spacing.small),
                    _SimpleCard(
                      onTap: () {
                        _showEditDailyDrinkingFrequency(
                          context: context,
                          onOk: (newDailyDrinkingFrequency) {
                            controller.setDailyDrinkingFrequency(newDailyDrinkingFrequency);

                            Navigator.pop(context);
                          },
                          dailyDrinkingFrequency: controller.waterDataEntity.dailyDrinkingFrequency,
                        );
                      },
                      text: 'Quantas vezes beber ao dia',
                      value:
                          '${controller.isLoading ? MIN_DAILY_DRINKING_FREQUENCY : controller.waterDataEntity.dailyDrinkingFrequency}',
                    ),
                    const SizedBox(height: Spacing.medium),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: Spacing.small3),
                      child: Icon(CommunityMaterialIcons.bed, size: Spacing.medium, color: MyColors.lightGrey3),
                    ),
                    const SizedBox(height: Spacing.small),
                    _SimpleCard(
                      text: 'Hora de acordar',
                      preffixIcon: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: Spacing.small1),
                        child: Icon(CupertinoIcons.sun_min, size: Spacing.normal),
                      ),
                      value: TimeOfDayUtils(controller.userEntity.wakeUpTime).toLiteral(),
                      onTap: () {
                        showEditTime(
                          title: 'Alterar hora de acordar',
                          context: context,
                          onOk: (wakeUpTime) {
                            controller.setWakeUpTime(wakeUpTime);

                            Navigator.pop(context);
                          },
                          timeOfDay: controller.userEntity.wakeUpTime,
                        );
                      },
                    ),
                    const SizedBox(height: Spacing.small2),
                    _SimpleCard(
                      preffixIcon: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: Spacing.small1),
                        child: Icon(CupertinoIcons.moon_zzz, size: Spacing.normal),
                      ),
                      text: 'Hora de dormir',
                      value: TimeOfDayUtils(controller.userEntity.sleeptime).toLiteral(),
                      onTap: () {
                        showEditTime(
                          title: 'Alterar hora de dormir',
                          context: context,
                          onOk: (sleeptime) {
                            controller.setSleepTime(sleeptime);

                            Navigator.pop(context);
                          },
                          timeOfDay: controller.userEntity.sleeptime,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SpecialCard extends StatelessWidget {
  final String text;
  final String value;
  final Function() onTap;
  final Widget? preffixIcon;

  const _SpecialCard({
    super.key,
    required this.text,
    required this.value,
    required this.onTap,
    this.preffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      borderRadius: BorderRadius.circular(Sizes.borderRadius),
      child: Ink(
        decoration: BoxDecoration(
          border: Border.all(color: MyColors.lightBlue2),
          color: MyColors.darkGrey,
          borderRadius: BorderRadius.circular(Sizes.borderRadius),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.small1,
          vertical: Spacing.small2,
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
                      Text(text, style: const TextStyle(color: MyColors.lightBlue)),
                    ],
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      value,
                      style: const TextStyle(fontWeight: FontWeight.w500, color: MyColors.lightBlue),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.small2),
              child: Icon(CupertinoIcons.pencil, color: MyColors.lightBlue),
            ),
          ],
        ),
      ),
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
      onTap: () {
        onTap();
      },
      borderRadius: BorderRadius.circular(Sizes.borderRadius),
      child: Ink(
        decoration: BoxDecoration(
          color: MyColors.darkGrey,
          borderRadius: BorderRadius.circular(Sizes.borderRadius),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.small1,
          vertical: Spacing.small2 + 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      preffixIcon ?? const SizedBox.shrink(),
                      const SizedBox(width: Spacing.small1),
                      Text(text),
                      const SizedBox(width: Spacing.small2),
                    ],
                  ),
                  Flexible(
                    child: Text(
                      value,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
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

Future<void> _showEditWeight({
  required BuildContext context,
  required Function(int weight) onOk,
  required int weight,
}) async {
  await BottomSheets.normal(
    context: context,
    title: 'Alterar peso',
    content: StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.small2,
            vertical: Spacing.medium,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                alignment: Alignment.center,
                child: NumberPicker(
                  initialValue: weight,
                  loop: true,
                  suffixWidget: const Text('kg'),
                  range: MAX_WEIGHT,
                  includeZero: false,
                  onChanged: (newWeight) {
                    setState(() {
                      weight = newWeight;
                    });
                  },
                ),
              ),
              const SizedBox(height: Spacing.small2),
              Button.ok(
                onPressed: () async {
                  onOk(weight);
                },
              ),
            ],
          ),
        );
      },
    ),
  );
}

Future<void> _showEditWeeklyWorkoutDays({
  required BuildContext context,
  required Function(int weight) onOk,
  required int weeklyWorkoutDays,
}) async {
  await BottomSheets.normal(
    context: context,
    title: 'Alterar dias de treino por semana',
    content: StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.small2,
            vertical: Spacing.medium,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                alignment: Alignment.center,
                child: NumberPicker(
                  suffixWidget: Text(weeklyWorkoutDays == 1 ? 'dia' : 'dias'),
                  range: DAYS_IN_A_WEEK,
                  initialValue: weeklyWorkoutDays,
                  onChanged: (newWeeklyWorkoutDays) {
                    setState(() {
                      weeklyWorkoutDays = newWeeklyWorkoutDays;
                    });
                  },
                ),
              ),
              const SizedBox(height: Spacing.small2),
              Button.ok(
                onPressed: () async {
                  onOk(weeklyWorkoutDays);
                },
              ),
            ],
          ),
        );
      },
    ),
  );
}

Future<void> _showEditDailyDrinkingFrequency({
  required BuildContext context,
  required Function(int dailyDrinkingFrequency) onOk,
  required int dailyDrinkingFrequency,
}) async {
  await BottomSheets.normal(
    context: context,
    title: 'Alterar quantas vezes beber ao dia',
    content: StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.small2,
            vertical: Spacing.medium,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                alignment: Alignment.center,
                child: NumberPicker(
                  suffixWidget: Text(dailyDrinkingFrequency == 1 ? 'vez' : 'vezes'),
                  range: MAX_DAILY_DRINKING_FREQUENCY,
                  includeZero: false,
                  initialValue: dailyDrinkingFrequency,
                  onChanged: (newDailyDrinkingFrequency) {
                    setState(() {
                      dailyDrinkingFrequency = newDailyDrinkingFrequency;
                    });
                  },
                ),
              ),
              const SizedBox(height: Spacing.small2),
              Button.ok(
                onPressed: () async {
                  onOk(dailyDrinkingFrequency);
                },
              ),
            ],
          ),
        );
      },
    ),
  );
}
