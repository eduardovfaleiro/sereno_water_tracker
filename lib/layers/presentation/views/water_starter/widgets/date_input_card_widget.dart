part of water_starter_view;

class DateInputCardWidget extends StatefulWidget {
  final Widget question;
  final void Function() onTap;

  const DateInputCardWidget({
    super.key,
    required this.onTap,
    required this.question,
  });

  @override
  State<DateInputCardWidget> createState() => _DateInputCardWidgetState();
}

class _DateInputCardWidgetState extends State<DateInputCardWidget> {
  var userViewModel = getIt<UserViewModel>();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, userViewModel, _) {
        return InkWell(
          onTap: widget.onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(Spacing.small3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.borderRadius),
              color: const Color(0xff0B131B),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.question,
                    (userViewModel.sleepTime != null && userViewModel.wakeUpTime != null)
                        ? Text(
                            'From ${getTimeOfDayValue(userViewModel.wakeUpTime!)} to '
                            '${getTimeOfDayValue(userViewModel.sleepTime!)}',
                          )
                        : const Text(
                            'Press to select time',
                            style: TextStyle(color: Color.fromARGB(255, 83, 137, 192)),
                          ),
                  ],
                ),
                const Icon(Icons.access_time_filled, color: Colors.grey),
              ],
            ),
          ),
        );
      },
    );
  }
}
