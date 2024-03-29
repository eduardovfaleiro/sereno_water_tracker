import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/themes.dart';

abstract class Button {
  static Widget ok({
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.buttonBorderRadius),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: Spacing.small2,
          horizontal: Spacing.small2,
        ),
      ),
      onPressed: () => onPressed(),
      child: const Text(
        'OK',
        style: TextStyle(color: MyColors.darkGrey),
      ),
    );
  }

  static Widget cancel({
    required VoidCallback onPressed,
    required String text,
  }) {
    return InkWell(
      onTap: () {},
      child: CupertinoButton(
        pressedOpacity: null,
        child: Text(
          text,
          style: const TextStyle(color: Color.fromARGB(255, 224, 73, 65)),
        ),
        onPressed: () => onPressed(),
      ),
    );
  }

  static Widget confirm({
    required VoidCallback onPressed,
    required String text,
  }) {
    return InkWell(
      onTap: () {},
      child: CupertinoButton(
        pressedOpacity: null,
        onPressed: () => onPressed(),
        child: Text(text),
      ),
    );
  }

  static Widget outlined({
    required VoidCallback onPressed,
    required String text,
    final IconData? suffixIcon,
  }) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.buttonBorderRadius),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: Spacing.small2,
          horizontal: Spacing.small2,
        ),
      ),
      onPressed: () {
        onPressed();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(color: MyColors.lightBlue, fontWeight: FontWeight.normal),
          ),
          if (suffixIcon != null)
            Align(
              alignment: Alignment.centerRight,
              child: Icon(
                suffixIcon,
                color: Colors.black,
                size: Spacing.small3,
              ),
            )
        ],
      ),
    );
  }

  static Widget normal({
    required VoidCallback onPressed,
    required String text,
    final IconData? suffixIcon,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.buttonBorderRadius),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: Spacing.small2,
          horizontal: Spacing.small2,
        ),
      ),
      onPressed: () {
        onPressed();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(color: Colors.black),
          ),
          if (suffixIcon != null)
            Align(
              alignment: Alignment.centerRight,
              child: Icon(
                suffixIcon,
                color: Colors.black,
                size: Spacing.small3,
              ),
            )
        ],
      ),
    );
  }
}

class CancelButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CancelButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: CupertinoButton(
        pressedOpacity: null,
        child: Text(
          text,
          style: const TextStyle(color: Color.fromARGB(255, 224, 73, 65)),
        ),
        onPressed: () => onPressed(),
      ),
    );
  }
}

class ConfirmButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const ConfirmButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: CupertinoButton(
        pressedOpacity: null,
        onPressed: () => onPressed(),
        child: Text(text),
      ),
    );
  }
}
