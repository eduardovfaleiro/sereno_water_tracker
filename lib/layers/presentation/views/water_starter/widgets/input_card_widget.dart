part of water_starter_view;

class InputCardWidget extends StatefulWidget {
  final Widget question;
  final Widget value;
  final Slider slider;

  const InputCardWidget({
    super.key,
    required this.question,
    required this.value,
    required this.slider,
  });

  @override
  State<InputCardWidget> createState() => _InputCardWidgetState();
}

class _InputCardWidgetState extends State<InputCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Spacing.small3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.borderRadius),
        color: const Color(0xff0B131B),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.question,
              widget.value,
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: Spacing.normal, bottom: Spacing.small2),
            child: widget.slider,
          ),
        ],
      ),
    );
  }
}
