import 'package:flutter/material.dart';

import '../../../core/theme/themes.dart';

abstract class Button {
  static Widget ok({
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      child: const Text(
        'OK',
        style: TextStyle(color: MyColors.darkGrey),
      ),
    );
  }
}
