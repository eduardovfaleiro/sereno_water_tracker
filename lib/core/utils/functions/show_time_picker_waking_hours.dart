part of water_starter_view;

Future<void> showTimePickerWakingHours({
  required BuildContext context,
  required UserViewModel userViewModel,
}) async {
  await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    helpText: 'When do you usually wake up?',
  ).then(
    (wakeUpTime) async {
      if (wakeUpTime == null) return;

      userViewModel.updateWakeUpTime(wakeUpTime);

      await showTimePicker(
        context: context,
        initialTime: wakeUpTime,
        helpText: 'When do you usually go sleep?',
      ).then((sleepTime) {
        if (sleepTime == null) return;

        userViewModel.updateSleepTime(sleepTime);
      });
    },
  );
}
