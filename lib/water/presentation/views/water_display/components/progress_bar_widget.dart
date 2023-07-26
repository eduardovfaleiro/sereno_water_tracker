part of water_display_view;

class ProgressBarWidget extends StatefulWidget {
  final Future<Result<double>> value;

  const ProgressBarWidget(this.value, {super.key});

  @override
  State<ProgressBarWidget> createState() => _ProgressBarWidgetState();
}

class _ProgressBarWidgetState extends State<ProgressBarWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        var percentage = snapshot.data as Result<double>?;

        if (snapshot.data == null) {
          return const LinearProgressIndicator(value: 0);
        }

        return LinearProgressIndicator(
          value: percentage!.fold((failure) => 0, (success) => success),
        );
      },
    );
  }
}
