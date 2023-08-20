import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/themes.dart';

class TimePicker extends StatefulWidget {
  final bool loopHour;
  final int maxHours;
  final int minHours;
  final TimeOfDay initialTime;
  final IconData? icon;
  final void Function(TimeOfDay) onHourChanged;
  final void Function(TimeOfDay) onMinuteChanged;

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
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  late int _hour;
  late int _minute;

  @override
  void initState() {
    super.initState();

    _hour = widget.initialTime.hour;
    _minute = widget.initialTime.minute;
  }

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
                scrollController: FixedExtentScrollController(initialItem: widget.initialTime.hour),
                selectionOverlay: null,
                offAxisFraction: -0.3,
                onSelectedItemChanged: (value) {
                  _hour = value;

                  final updatedTimeOfDay = TimeOfDay(
                    hour: _hour,
                    minute: _minute,
                  );

                  widget.onHourChanged(updatedTimeOfDay);
                },
                itemExtent: 35,
                diameterRatio: 0.8,
                children: List.generate(widget.maxHours, (index) {
                  return Center(child: Text(index.toString().padLeft(2, '0')));
                }),
              ),
            ),
            Container(
              width: Spacing.huge,
              alignment: Alignment.centerLeft,
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(initialItem: widget.initialTime.minute),
                selectionOverlay: null,
                magnification: 1.05,
                offAxisFraction: 0.3,
                diameterRatio: 0.8,
                onSelectedItemChanged: (value) {
                  _minute = value;

                  final updatedTimeOfDay = TimeOfDay(
                    hour: _hour,
                    minute: _minute,
                  );

                  widget.onMinuteChanged(updatedTimeOfDay);
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
            if (widget.icon != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: Spacing.small3),
                  Icon(widget.icon),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
