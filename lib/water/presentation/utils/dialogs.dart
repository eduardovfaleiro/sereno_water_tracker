import 'package:flutter/material.dart';

abstract class Dialogs {
  static Future<void> normal({
    required BuildContext context,
    required Widget child,
  }) async {
    await showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      pageBuilder: (_, __, ___) => child,
      context: context,
      transitionBuilder: (context, a1, a2, child) {
        double curve = Curves.easeInOut.transform(a1.value);

        return Transform.scale(scale: curve, child: child);
      },
      transitionDuration: const Duration(milliseconds: 200),
    );
  }
}
