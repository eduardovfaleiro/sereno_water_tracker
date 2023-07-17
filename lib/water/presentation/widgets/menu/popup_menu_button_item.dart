import 'package:flutter/material.dart';

import '../../../../core/theme/themes.dart';

class PopupMenuButtonItem extends PopupMenuEntry {
  final VoidCallback onTap;
  final Text label;
  final Icon icon;
  final BorderRadius borderRadius;

  const PopupMenuButtonItem({
    required this.onTap,
    required this.label,
    required this.icon,
    required this.borderRadius,
    super.key,
  });

  @override
  State<PopupMenuButtonItem> createState() => _PopupMenuButtonItemState();

  @override
  double get height => throw UnimplementedError();

  @override
  bool represents(value) => throw UnimplementedError();
}

class _PopupMenuButtonItemState extends State<PopupMenuButtonItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => widget.onTap(),
          borderRadius: widget.borderRadius,
          child: Ink(
            decoration: BoxDecoration(color: MyColors.darkGrey, borderRadius: widget.borderRadius),
            padding: const EdgeInsets.symmetric(vertical: Spacing.small1),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: Spacing.small2),
              child: Column(
                children: [widget.icon, const SizedBox(height: Spacing.tiny), widget.label],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
