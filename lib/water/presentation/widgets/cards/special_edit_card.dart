import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/themes.dart';

class SpecialEditCard extends StatelessWidget {
  final String text;
  final String value;
  final Function() onTap;
  final Widget? preffixIcon;

  const SpecialEditCard({
    super.key,
    required this.text,
    required this.value,
    required this.onTap,
    this.preffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      borderRadius: BorderRadius.circular(Sizes.borderRadius),
      child: Ink(
        decoration: BoxDecoration(
          border: Border.all(color: MyColors.lightBlue2),
          color: MyColors.darkGrey,
          borderRadius: BorderRadius.circular(Sizes.borderRadius),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.small1,
          vertical: Spacing.small2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      preffixIcon ?? const SizedBox.shrink(),
                      const SizedBox(width: Spacing.small1),
                      Text(text, style: const TextStyle(color: MyColors.lightBlue)),
                    ],
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      value,
                      style: const TextStyle(fontWeight: FontWeight.w500, color: MyColors.lightBlue),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.small2),
              child: Icon(CupertinoIcons.pencil, color: MyColors.lightBlue),
            ),
          ],
        ),
      ),
    );
  }
}
