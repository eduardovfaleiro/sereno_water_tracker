part of water_view;

class WaterDataWidget extends StatelessWidget {
  final String text;
  final int value;

  const WaterDataWidget(this.text, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(text), Text('$value ml', style: const TextStyle(color: MyColors.lightBlue))],
    );
  }
}
