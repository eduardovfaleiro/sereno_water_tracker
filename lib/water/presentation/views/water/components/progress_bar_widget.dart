part of water_view;

class ProgressBarWidget extends StatefulWidget {
  final Future<Result<double>> value;
  const ProgressBarWidget(this.value, {super.key});

  @override
  State<ProgressBarWidget> createState() => _ProgressBarWidgetState();
}

class _ProgressBarWidgetState extends State<ProgressBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      child: FutureBuilder(
        future: widget.value,
        builder: (context, snapshot) {
          Result<double>? percentage = snapshot.data;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator(value: 0);
          }

          return LinearProgressIndicator(
            value: percentage!.fold((failure) => 0, (success) => success),
          );
        },
      ),
    );
  }
}
