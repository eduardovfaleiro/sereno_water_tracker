// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../core/functions/datetime_to_timeofday.dart';
import '../../../../core/theme/themes.dart';
import '../../controllers/reminder_controller.dart';
import '../../utils/dialogs.dart';
import '../../utils/edit_dialogs/show_edit_time.dart';
import 'reminder_card.dart';

final _controller = getIt<ReminderController>();

class ReminderView extends StatefulWidget {
  const ReminderView({super.key});

  @override
  State<ReminderView> createState() => _ReminderViewState();
}

class _ReminderViewState extends State<ReminderView> {
  @override
  void initState() {
    super.initState();

    _controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReminderController>(
      builder: (context, _, __) {
        return Scaffold(
          floatingActionButton: const _AddReminderComponent(),
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(
                top: Spacing.huge,
                left: Spacing.small2,
                right: Spacing.small2,
              ),
              child: const _RemindersListComponent(),
            ),
          ),
        );
      },
    );
  }
}

class _AddReminderComponent extends StatelessWidget {
  const _AddReminderComponent();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showEditTime(
          context: context,
          title: 'Adicionar lembrete',
          onOk: (reminder) async {
            await _controller.add(context, reminder);

            Navigator.pop(context);
          },
          timeOfDay: DateTime.now().toTimeOfDay(),
        );
      },
      backgroundColor: MyColors.lightBlue,
      child: const Icon(Icons.add, color: Colors.black),
    );
  }
}

class _RemindersListComponent extends StatefulWidget {
  const _RemindersListComponent();

  @override
  State<_RemindersListComponent> createState() => _RemindersListComponentState();
}

class _RemindersListComponentState extends State<_RemindersListComponent> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _controller.reminders.length,
      itemBuilder: (context, index) {
        TimeOfDay reminder = _controller.reminders[index];

        return Column(
          children: [
            ReminderCard(
              reminder,
              onEdit: (newReminder) async {
                await _controller.update(
                  context,
                  key: reminder,
                  newValue: newReminder,
                );
                Navigator.pop(context);
              },
              onDelete: () async {
                if (await Dialogs.confirm(
                        title: 'Excluir lembrete?',
                        text: 'Deseja mesmo excluir lembrete?',
                        cancelText: 'Cancelar',
                        confirmText: 'Sim, excluir',
                        context: context) !=
                    true) {
                  return Navigator.pop(context);
                }

                await _controller.delete(context, reminder);
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: Spacing.small1),
          ],
        );
      },
    );
  }
}
