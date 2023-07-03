part of water_starter_view;

Future<void> showTimePickerWakingHours({
  required BuildContext context,
  required UserEntityViewModel userEntityViewModel,
}) async {
  Future<TimeOfDay?> showWakeUpTimePicker() {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: 'When do you usually wake up?',
    );
  }

  Future<TimeOfDay?> showSleepTimePicker({required TimeOfDay? wakeUpTime}) {
    return showTimePicker(
      context: context,
      initialTime: wakeUpTime ?? TimeOfDay.now(),
      helpText: 'When do you usually go sleep?',
    );
  }

  await showWakeUpTimePicker().then(
    (wakeUpTime) async {
      userEntityViewModel.updateWakeUpTime(wakeUpTime);

      await showSleepTimePicker(wakeUpTime: wakeUpTime).then((sleepTime) {
        userEntityViewModel.updateSleepTime(sleepTime);
      });
    },
  );
}
