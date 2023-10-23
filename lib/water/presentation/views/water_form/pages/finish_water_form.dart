import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';

import '../../../../../core/core.dart';
import '../../../../../core/functions/datetime_to_timeofday.dart';
import '../../../../../core/functions/time_of_day_utils.dart';
import '../../../../../core/theme/themes.dart';
import '../../../../../main.dart';
import '../../../controllers/water_form_controller.dart';
import '../../../utils/dialogs.dart';
import '../../../utils/edit_dialogs/show_edit_daily_goal.dart';
import '../../../utils/edit_dialogs/show_edit_time.dart';
import '../../../utils/snackbar_message.dart';
import '../../../widgets/buttons/button.dart';
import '../../../widgets/edit_card.dart';
import '../water_form_view.dart';

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
              padding: const EdgeInsets.symmetric(horizontal: Spacing.normal, vertical: Spacing.normal),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Button.normal(
                      onPressed: () async {
                        var saveDataResult = await getResult(controller.saveData());

                        if (saveDataResult is Failure) {
                          SnackBarMessage.error(saveDataResult, context: context);
                        } else {
                          await initializeApp();

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const Sereno(isSessionValid: true)),
                          );
                        }
                      },
                      text: 'Finalizar',
                    ),
                    const SizedBox(height: Spacing.small),
                    Button.outlined(
                      onPressed: () async {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const WaterFormView()),
                        );
                      },
                      text: 'Voltar para formulário',
                    ),
                  ],
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: Spacing.small3, right: Spacing.small3),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                    top: Spacing.small, left: Spacing.small, right: Spacing.small, bottom: Spacing.small),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Antes de finalizar...',
                      style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: FontSize.small3),
                    ),
                    const Text(
                      'Estes foram os dados gerados',
                      style: TextStyle(fontSize: FontSize.small2),
                    ),
                    const Divider(
                      height: Spacing.big,
                      thickness: 1,
                    ),
                    const SizedBox(height: Spacing.normal),
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
                      preffixIcon: const Icon(Icons.water_drop, color: MyColors.lightGrey2),
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ...List.generate(
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
                                      context: context,
                                      onNo: () {
                                        Navigator.pop(context);
                                      },
                                      onYes: () async {
                                        await controller.deleteReminder(context: context, reminder: timeToDrink);
                                        Navigator.pop(context);
                                      });
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
                          InkWell(
                            onTap: () {
                              showEditTime(
                                context: context,
                                title: 'Adicionar lembrete',
                                onOk: (reminder) async {
                                  controller.addReminder(context: context, reminder: reminder);

                                  Navigator.pop(context);
                                },
                                timeOfDay: DateTime.now().toTimeOfDay(),
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: Spacing.small2),
                              child: Icon(Icons.add, color: MyColors.lightGrey),
                            ),
                          ),
                        ],
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
