import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/themes.dart';
import '../../controllers/water_form_controller.dart';
import '../../widgets/time_picker.dart';

class SleepHabitWaterForm extends StatefulWidget {
  const SleepHabitWaterForm({super.key});

  @override
  State<SleepHabitWaterForm> createState() => _SleepHabitWaterFormState();
}

class _SleepHabitWaterFormState extends State<SleepHabitWaterForm> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WaterFormController>(
      builder: (context, controller, _) {
        return SingleChildScrollView(
          padding: const EdgeInsets.only(top: Spacing.small),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Sono', style: TextStyle(fontWeight: FontWeight.w500)),
              const Divider(
                height: Spacing.small3,
                thickness: 1,
              ),
              const SizedBox(height: Spacing.medium1),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: FontSize.small2, color: MyColors.lightGrey),
                  text: 'Que horas você geralmente ',
                  children: [
                    TextSpan(
                      text: 'acorda',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: '?'),
                  ],
                ),
              ),
              const SizedBox(height: Spacing.small),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                alignment: Alignment.center,
                child: TimePicker(
                  icon: CupertinoIcons.sun_max,
                  initialTime: controller.user.wakeUpTime,
                  onHourChanged: (value) {
                    controller.setWakeUpTime(value);
                  },
                  onMinuteChanged: (value) {
                    controller.setWakeUpTime(value);
                  },
                ),
              ),
              const SizedBox(height: Spacing.medium1),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: FontSize.small2, color: MyColors.lightGrey),
                  text: 'Que horas você geralmente vai ',
                  children: [
                    TextSpan(
                      text: 'dormir',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: '?'),
                  ],
                ),
              ),
              const SizedBox(height: Spacing.small),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                alignment: Alignment.center,
                child: TimePicker(
                  initialTime: controller.user.sleeptime,
                  icon: CupertinoIcons.moon,
                  onHourChanged: (value) {
                    controller.setSleeptime(value);
                  },
                  onMinuteChanged: (value) {
                    controller.setSleeptime(value);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
