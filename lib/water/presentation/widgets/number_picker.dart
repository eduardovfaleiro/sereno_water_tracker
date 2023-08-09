import 'package:flutter/cupertino.dart';

import '../../../core/theme/themes.dart';

class NumberPicker extends StatelessWidget {
  final int range;
  final int? initialValue;
  final bool includeZero;
  final Widget? suffixWidget;
  final void Function(int) onChanged;
  final bool loop;

  const NumberPicker({
    super.key,
    this.suffixWidget,
    required this.range,
    this.includeZero = true,
    required this.onChanged,
    this.loop = false,
    this.initialValue,
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
                scrollController: FixedExtentScrollController(
                  initialItem: includeZero ? initialValue ?? 0 : (initialValue ?? 1) - 1,
                ),
                magnification: 1.05,
                selectionOverlay: null,
                // offAxisFraction: -0.3,
                onSelectedItemChanged: (value) {
                  if (includeZero) {
                    onChanged(value);
                  } else {
                    onChanged(value + 1);
                  }
                },

                looping: loop,
                itemExtent: 35,
                diameterRatio: 0.8,
                children: includeZero
                    ? List.generate(range + 1, (index) {
                        return Center(
                          child: Text('$index'),
                        );
                      })
                    : List.generate(range + 1, (index) {
                        return Center(
                          child: Text('$index'),
                        );
                      }).sublist(1),
              ),
            ),
            if (suffixWidget != null) suffixWidget!,
          ],
        ),
      ],
    );
  }
}
