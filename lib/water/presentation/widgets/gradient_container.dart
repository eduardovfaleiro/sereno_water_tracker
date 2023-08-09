import 'package:flutter/cupertino.dart';

class GradientContainer extends StatelessWidget {
  final Gradient gradient;
  final Widget child;

  const GradientContainer({super.key, required this.gradient, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(decoration: BoxDecoration(gradient: gradient)),
        child,
      ],
    );
  }
}
