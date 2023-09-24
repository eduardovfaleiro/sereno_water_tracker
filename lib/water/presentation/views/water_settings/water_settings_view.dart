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
import '../../utils/edit_dialogs/show_edit_daily_drinking_frequency.dart';
import '../../utils/edit_dialogs/show_edit_daily_goal.dart';
import '../../utils/edit_dialogs/show_edit_time.dart';
import '../../utils/edit_dialogs/show_edit_weekly_workout_days.dart';
import '../../utils/edit_dialogs/show_edit_weight.dart';
import '../../utils/snackbar_message.dart';
import '../../widgets/cards/special_edit_card.dart';
import '../../widgets/edit_card.dart';

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
                    SnackBarMessage.normal(context: context, text: 'Dados redefinidos');
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
                    SpecialEditCard(
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
                    EditCard(
                      text: 'Peso',
                      value: '${controller.isLoading ? MIN_WEIGHT : controller.userEntity.weight} kg',
                      onTap: () async {
                        await showEditWeight(
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
                    EditCard(
                      text: 'Dias de treino por semana',
                      value: '${controller.isLoading ? 0 : controller.userEntity.weeklyWorkoutDays} dias',
                      onTap: () async {
                        await showEditWeeklyWorkoutDays(
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
                    EditCard(
                      onTap: () {
                        showEditDailyDrinkingFrequency(
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
                    EditCard(
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
                    EditCard(
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
