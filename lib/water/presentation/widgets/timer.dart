import 'package:flutter/cupertino.dart';

class TimerWidget extends StatelessWidget {
  final Stream<Duration> stream;

  const TimerWidget({super.key, required this.stream});

  String getText({required Duration duration}) {
    if (duration.inSeconds < 60) {
      if (duration.inSeconds == 1) {
        return '${duration.inSeconds} segundo';
      }

      return '${duration.inSeconds} segundos';
    }

    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Text('00:00');
        }

        return Text(getText(duration: snapshot.data!));
      },
    );
  }
}
