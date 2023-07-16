import 'package:flutter/material.dart';

import '../../../../core/theme/themes.dart';

class PopupMenuWrap extends PopupMenuEntry {
  final List<PopupMenuEntry> items;
  final Axis direction;
  final double runSpacing;
  final double spacing;

  const PopupMenuWrap({
    super.key,
    required this.items,
    this.direction = Axis.horizontal,
    this.runSpacing = Spacing.zero,
    this.spacing = Spacing.zero,
  });

  @override
  State<PopupMenuWrap> createState() => _PopupMenuWrapState();

  @override
  double get height => throw UnimplementedError();

  @override
  bool represents(value) => throw UnimplementedError();
}

class _PopupMenuWrapState extends State<PopupMenuWrap> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: widget.spacing,
      runSpacing: widget.runSpacing,
      direction: widget.direction,
      children: widget.items,
    );
  }
}
