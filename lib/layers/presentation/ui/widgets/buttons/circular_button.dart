import 'package:flutter/material.dart';

import 'button.dart';

final class CircularButton extends StatelessWidget implements Button {
  @override
  final Widget child;
  final VoidCallback? onLongPress;
  final VoidCallback? onTap;

  const CircularButton({
    super.key,
    required this.child,
    this.onLongPress,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(180),
          onLongPress: onLongPress,
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(180)),
            child: Center(child: child),
          ),
        ),
      ],
    );
  }
}
