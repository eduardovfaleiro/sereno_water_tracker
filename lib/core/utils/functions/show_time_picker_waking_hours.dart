part of water_starter_view;

Future<void> showTimePickerWakingHours({
  required BuildContext context,
  required UserEntityViewModel userEntityViewModel,
}) async {
  await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    helpText: 'When do you usually wake up?',
  ).then(
    (wakeUpTime) async {
      if (wakeUpTime == null) return;

      userEntityViewModel.updateWakeUpTime(wakeUpTime);

      await showTimePicker(
        context: context,
        initialTime: wakeUpTime,
        helpText: 'When do you usually go sleep?',
      ).then((sleepTime) {
        if (sleepTime == null) return;

        userEntityViewModel.updateSleepTime(sleepTime);
      });
    },
  );
}
