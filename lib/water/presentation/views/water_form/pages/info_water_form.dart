import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/functions/time_of_day_utils.dart';
import '../../../../../core/theme/themes.dart';
import '../../../controllers/water_form_controller.dart';
import '../../../utils/bottom_sheets.dart';
import '../../../utils/show_edit_reminder.dart';
import '../../../widgets/buttons/button.dart';
import '../../../widgets/my_text_fields.dart';

class InfoWaterForm extends StatefulWidget {
  const InfoWaterForm({super.key});

  @override
  State<InfoWaterForm> createState() => _InfoWaterFormState();
}

class _InfoWaterFormState extends State<InfoWaterForm> {
  @override
  void initState() {
    super.initState();

    context.read<WaterFormController>().initInfoPage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WaterFormController>(
      builder: (context, controller, _) {
        return SingleChildScrollView(
          padding: const EdgeInsets.only(top: Spacing.small, left: Spacing.small, right: Spacing.small, bottom: 140),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Antes de finalizar...',
                style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: FontSize.small3),
              ),
              const Text(
                'Isso está correto?',
                style: TextStyle(fontSize: FontSize.small2),
              ),
              const Divider(
                height: Spacing.big,
                thickness: 1,
              ),
              const SizedBox(height: Spacing.normal),
              InkWell(
                borderRadius: BorderRadius.circular(Sizes.borderRadius),
                onTap: () {
                  _showEditDailyGoalBottomSheet(
                    context: context,
                    onOk: (dailyGoal) {
                      controller.setDailyGoal(dailyGoal);
                      Navigator.pop(context);
                    },
                  );
                },
                child: Ink(
                  padding: const EdgeInsets.all(Spacing.small3),
                  decoration: BoxDecoration(
                    color: MyColors.darkGrey,
                    borderRadius: BorderRadius.circular(Sizes.borderRadius),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Row(
                          children: [
                            Icon(CupertinoIcons.drop_fill, color: MyColors.lightGrey2),
                            SizedBox(width: Spacing.small2),
                            Expanded(child: Text('Meta diária')),
                          ],
                        ),
                      ),
                      Text('${controller.waterData.dailyGoal} ml', style: const TextStyle(color: MyColors.lightBlue)),
                      const SizedBox(width: Spacing.small3),
                      const Icon(CupertinoIcons.pencil, color: MyColors.lightGrey3),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: Spacing.small1),
              Container(
                padding: const EdgeInsets.all(Spacing.small3),
                decoration: const BoxDecoration(
                  color: MyColors.darkGrey,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(Sizes.borderRadius),
                  ),
                ),
                child: const Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.bell_fill, color: MyColors.lightGrey2),
                          SizedBox(width: Spacing.small2),
                          Expanded(child: Text('Lembretes')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: MyColors.darkGrey, width: Spacing.tiny),
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(Sizes.borderRadius)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    controller.waterData.timesToDrink.length,
                    (index) {
                      final TimeOfDay timeToDrink = controller.waterData.timesToDrink[index];

                      return _ReminderCard(
                        reminder: timeToDrink,
                        onDelete: (timeToDrink) {},
                        onEdit: (timeToDrink) {
                          showEditReminder(
                            context: context,
                            onOk: (newReminder) {
                              controller.editReminder(
                                context: context,
                                oldReminder: timeToDrink,
                                newReminder: newReminder,
                              );
                            },
                            reminder: timeToDrink,
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Future<void> _showEditDailyGoalBottomSheet({
  required BuildContext context,
  required Function(int dailyGoal) onOk,
}) async {
  int? amount;
  final formKey = GlobalKey<FormState>();

  await BottomSheets.normal(
    context: context,
    title: 'Alterar meta diária',
    content: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.small2,
        vertical: Spacing.medium,
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: Spacing.small1),
            DigitOnlyTextField(
              suffix: 'ml',
              label: 'Meta diária',
              maxLength: 5,
              autofocus: true,
              onChanged: (value) {
                amount = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Insira uma meta diária.';
                }

                return null;
              },
            ),
            const SizedBox(height: Spacing.small2),
            Button.ok(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await onOk(amount!);
                }
              },
            ),
          ],
        ),
      ),
    ),
  );
}

class _ReminderCard extends StatelessWidget {
  final TimeOfDay reminder;
  final Function(TimeOfDay reminder) onDelete;
  final Function(TimeOfDay reminder) onEdit;

  const _ReminderCard({
    required this.reminder,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.small3, vertical: Spacing.small2),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: MyColors.darkGrey)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(TimeOfDayUtils(reminder).toLiteral()),
          Row(
            children: [
              IconButton(
                icon: const Icon(CupertinoIcons.pencil, color: MyColors.lightGrey3),
                onPressed: () async {
                  await onEdit(reminder);
                },
              ),
              const SizedBox(width: Spacing.small2),
              IconButton(
                icon: const Icon(CupertinoIcons.delete, color: MyColors.lightGrey3),
                onPressed: () async {
                  await onDelete(reminder);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
