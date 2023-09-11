import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/core.dart';
import '../../../../../core/functions/time_of_day_utils.dart';
import '../../../../../core/theme/themes.dart';
import '../../../controllers/water_form_controller.dart';
import '../../../utils/dialogs.dart';
import '../../../utils/edit_dialogs/show_edit_daily_goal.dart';
import '../../../utils/edit_dialogs/show_edit_time.dart';
import '../../../utils/snackbar_message.dart';
import '../../../widgets/buttons/button.dart';
import '../../../widgets/edit_card.dart';

class FinishWaterForm extends StatefulWidget {
  const FinishWaterForm({super.key});

  @override
  State<FinishWaterForm> createState() => _FinishWaterFormState();
}

class _FinishWaterFormState extends State<FinishWaterForm> {
  @override
  void initState() {
    super.initState();

    context.read<WaterFormController>().initFinishPage();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WaterFormController>(
      builder: (context, controller, _) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.normal),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Button.outlined(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/waterForm');
                      },
                      text: 'Voltar para formulário',
                    ),
                    const SizedBox(height: Spacing.small),
                    Button.normal(
                      onPressed: () async {
                        var saveDataResult = await getResult(controller.saveData());

                        if (saveDataResult is Failure) {
                          SnackBarMessage.error(saveDataResult, context: context);
                        } else {
                          Navigator.pushReplacementNamed(context, '/home');
                        }
                      },
                      text: 'Finalizar',
                    ),
                  ],
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: Spacing.small3, right: Spacing.small3),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: Spacing.small, left: Spacing.small, right: Spacing.small),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Antes de finalizar...',
                      style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: FontSize.small3),
                    ),
                    const Text(
                      'Esses foram os dados gerados, você pode alterá-los como quiser',
                      style: TextStyle(fontSize: FontSize.small2),
                    ),
                    const Divider(
                      height: Spacing.big,
                      thickness: 1,
                    ),
                    const SizedBox(height: Spacing.normal),
                    // EditCard(
                    //   text: 'Peso',
                    //   value: '${controller.user.weight} kg',
                    //   onTap: () {
                    //     showEditWeight(
                    //       context: context,
                    //       onOk: (weight) {
                    //         controller.setWeight(weight);
                    //         Navigator.pop(context);
                    //       },
                    //       weight: controller.user.weight,
                    //     );
                    //   },
                    // ),
                    // const SizedBox(height: Spacing.small),
                    // EditCard(
                    //   text: 'Quantas vezes beber ao dia',
                    //   value: '${controller.waterData.dailyDrinkingFrequency}',
                    //   onTap: () {
                    //     showEditDailyDrinkingFrequency(
                    //       context: context,
                    //       onOk: (weight) {
                    //         controller.setWeight(weight);
                    //         Navigator.pop(context);
                    //       },
                    //       dailyDrinkingFrequency: controller.waterData.dailyDrinkingFrequency,
                    //     );
                    //   },
                    // ),
                    // const SizedBox(height: Spacing.small),
                    // EditCard(
                    //   text: 'Dias de treino por semana',
                    //   value: '${controller.user.weeklyWorkoutDays}',
                    //   onTap: () {
                    //     showEditWeeklyWorkoutDays(
                    //       context: context,
                    //       onOk: (weeklyWorkoutDays) {
                    //         controller.setWeeklyWorkoutDays(weeklyWorkoutDays);
                    //         Navigator.pop(context);
                    //       },
                    //       weeklyWorkoutDays: controller.user.weeklyWorkoutDays,
                    //     );
                    //   },
                    // ),
                    const SizedBox(height: Spacing.small),
                    EditCard(
                      text: 'Meta diária',
                      value: '${controller.waterData.dailyGoal} ml',
                      onTap: () {
                        showEditDailyGoalBottomSheet(
                          context: context,
                          onOk: (dailyGoal) {
                            controller.setDailyGoal(dailyGoal);
                            Navigator.pop(context);
                          },
                        );
                      },
                      preffixIcon: const Icon(CupertinoIcons.drop_fill, color: MyColors.lightGrey2),
                    ),
                    const SizedBox(height: Spacing.small1),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Spacing.small1,
                        vertical: Spacing.small2 + 2,
                      ),
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
                                SizedBox(width: Spacing.small1),
                                Expanded(child: Text('Lembretes')),
                                SizedBox(width: Spacing.small2),
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
                              onDelete: () async {
                                await Dialogs.confirm(
                                  title: 'Excluir lembrete?',
                                  text: 'O lembrete não poderá ser recuperado.',
                                  cancelText: 'Cancelar',
                                  confirmText: 'Sim, excluir',
                                  onYes: () async {
                                    await controller.deleteReminder(context: context, reminder: timeToDrink);

                                    Navigator.pop(context);
                                  },
                                  onNo: () {
                                    Navigator.pop(context);
                                  },
                                  context: context,
                                );
                              },
                              onEdit: (timeToDrink) {
                                showEditTime(
                                  context: context,
                                  title: 'Alterar lembrete',
                                  onOk: (newReminder) {
                                    controller.editReminder(
                                      context: context,
                                      oldReminder: timeToDrink,
                                      newReminder: newReminder,
                                    );
                                  },
                                  timeOfDay: timeToDrink,
                                );
                              },
                            );
                          },
                        ),
                      ),
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

class _ReminderCard extends StatelessWidget {
  final TimeOfDay reminder;
  final Function() onDelete;
  final Function(TimeOfDay reminder) onEdit;

  const _ReminderCard({
    required this.reminder,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.small2, vertical: Spacing.small1),
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
                  await onDelete();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
