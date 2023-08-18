import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../core/theme/themes.dart';
import '../../controllers/water_settings_controller.dart';
import '../../widgets/buttons/button.dart';
import '../../widgets/time_picker.dart';

class WaterSettingsView extends StatefulWidget {
  const WaterSettingsView({super.key});

  @override
  State<WaterSettingsView> createState() => _WaterSettingsViewState();
}

class _WaterSettingsViewState extends State<WaterSettingsView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WaterSettingsController>(
      builder: (context, controller, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Configurar seus dados', style: TextStyle(color: MyColors.lightGrey)),
          ),
          bottomNavigationBar: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.small2,
                vertical: Spacing.small1,
              ),
              child: Button.normal(onPressed: () {}, text: 'Salvar')),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(Spacing.small2),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Peso'),
                          Text('${controller.userEntity.weight}kg'),
                        ],
                      ),
                      const SizedBox(height: Spacing.small2),
                      Slider(
                        min: MIN_WEIGHT.toDouble(),
                        max: MAX_WEIGHT.toDouble(),
                        value: controller.userEntity.weight.toDouble(),
                        onChanged: (value) {
                          controller.setWeight(value.toInt());
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(height: Spacing.big, thickness: 1.5, color: MyColors.darkGrey1),
                Padding(
                  padding: const EdgeInsets.all(Spacing.small2),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Dias de treino por semana'),
                          Text('${controller.userEntity.weeklyWorkoutDays} dias'),
                        ],
                      ),
                      const SizedBox(height: Spacing.small2),
                      Slider(
                        max: DAYS_IN_A_WEEK.toDouble(),
                        value: controller.userEntity.weeklyWorkoutDays.toDouble(),
                        onChanged: (value) {
                          controller.setWeeklyWorkoutDays(value.toInt());
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(height: Spacing.big, thickness: 1.5, color: MyColors.darkGrey1),
                Padding(
                  padding: const EdgeInsets.all(Spacing.small2),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Quantas vezes beber por dia'),
                          Text('${controller.waterDataEntity.dailyDrinkingFrequency} vezes'),
                        ],
                      ),
                      const SizedBox(height: Spacing.small2),
                      Slider(
                        min: MIN_DAILY_DRINKING_FREQUENCY.toDouble(),
                        max: MAX_DAILY_DRINKING_FREQUENCY.toDouble(),
                        value: controller.waterDataEntity.dailyDrinkingFrequency.toDouble(),
                        onChanged: (value) {
                          controller.setDailyDrinkingFrequency(value.toInt());
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(height: Spacing.big, thickness: 1.5, color: MyColors.darkGrey1),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Spacing.small2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Hora de acordar'),
                      const SizedBox(height: Spacing.small),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        alignment: Alignment.center,
                        child: TimePicker(
                          icon: CupertinoIcons.sun_max,
                          initialTime: TimeOfDay.now(),
                          onHourChanged: (value) {},
                          onMinuteChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: Spacing.big, thickness: 1.5, color: MyColors.darkGrey1),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Spacing.small2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Hora de dormir'),
                      const SizedBox(height: Spacing.small),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        alignment: Alignment.center,
                        child: TimePicker(
                          initialTime: const TimeOfDay(hour: 0, minute: 0),
                          icon: CupertinoIcons.moon,
                          onHourChanged: (value) {},
                          onMinuteChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
