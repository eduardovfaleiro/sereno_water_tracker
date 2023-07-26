part of water_display_view;

class DurationWidget extends StatelessWidget {
  final String text;
  final Duration value;

  const DurationWidget(this.text, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text),
        const Text(
          '3h 27min',
          style: TextStyle(color: Color(0xFF4E9CC8)),
        ),
      ],
    );
  }
}
