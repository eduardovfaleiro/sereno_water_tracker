import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/themes.dart';

class TimePicker extends StatelessWidget {
  final bool loopHour;
  final int maxHours;
  final int minHours;
  final TimeOfDay initialTime;
  final IconData? icon;
  final void Function(int) onHourChanged;
  final void Function(int) onMinuteChanged;

  const TimePicker({
    super.key,
    this.icon,
    this.maxHours = 24,
    this.minHours = 0,
    required this.onHourChanged,
    required this.initialTime,
    required this.onMinuteChanged,
    this.loopHour = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 35 * 1.05,
          decoration: BoxDecoration(
            color: MyColors.darkGrey2,
            borderRadius: BorderRadius.circular(Sizes.borderRadius),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: Spacing.huge,
              alignment: Alignment.centerRight,
              child: CupertinoPicker(
                magnification: 1.05,
                scrollController: FixedExtentScrollController(initialItem: initialTime.hour),
                selectionOverlay: null,
                offAxisFraction: -0.3,
                onSelectedItemChanged: (value) {
                  onHourChanged(value);
                },
                itemExtent: 35,
                diameterRatio: 0.8,
                children: List.generate(maxHours, (index) {
                  return Center(child: Text(index.toString().padLeft(2, '0')));
                }),
              ),
            ),
            Container(
              width: Spacing.huge,
              alignment: Alignment.centerLeft,
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(initialItem: initialTime.minute),
                selectionOverlay: null,
                magnification: 1.05,
                offAxisFraction: 0.3,
                diameterRatio: 0.8,
                onSelectedItemChanged: (value) {
                  onMinuteChanged(value);
                },
                itemExtent: 35,
                children: List.generate(
                  60,
                  (index) {
                    return Center(
                      child: Text(index.toString().padLeft(2, '0')),
                    );
                  },
                ),
              ),
            ),
            if (icon != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: Spacing.small3),
                  Icon(icon),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
