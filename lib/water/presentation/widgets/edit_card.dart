import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/themes.dart';

class EditCard extends StatelessWidget {
  final String text;
  final String value;
  final Function() onTap;
  final Widget? preffixIcon;

  const EditCard({
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
          color: MyColors.darkGrey,
          borderRadius: BorderRadius.circular(Sizes.borderRadius),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.small1,
          vertical: Spacing.small2 + 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      preffixIcon ?? const SizedBox.shrink(),
                      const SizedBox(width: Spacing.small1),
                      Text(text),
                      const SizedBox(width: Spacing.small2),
                    ],
                  ),
                  Flexible(
                    child: Text(
                      value,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.small2),
              child: Icon(CupertinoIcons.pencil, color: MyColors.lightGrey),
            ),
          ],
        ),
      ),
    );
  }
}
