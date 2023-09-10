import 'package:flutter/material.dart';

import '../widgets/dialogs/confirm_custom_dialog.dart';
import '../widgets/dialogs/confirm_dialog.dart';

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

  static Future<dynamic> confirm({
    required String title,
    required String text,
    required Function() onYes,
    required Function() onNo,
    required BuildContext context,
    String? confirmText,
    String? cancelText,
  }) async {
    await showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      pageBuilder: (_, __, ___) {
        return ConfirmDialog(
          title: title,
          text: text,
          onNo: () async {
            await onNo();
            return false;
          },
          onYes: () async {
            await onYes();
            return true;
          },
          confirmText: confirmText,
          cancelText: cancelText,
        );
      },
      context: context,
      transitionBuilder: (context, a1, a2, child) {
        double curve = Curves.easeInOut.transform(a1.value);

        return Transform.scale(scale: curve, child: child);
      },
      transitionDuration: const Duration(milliseconds: 200),
    );
  }

  static Future<dynamic> confirmCustom({
    required String title,
    required String text,
    required BuildContext context,
    required Widget actions,
  }) async {
    await showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      pageBuilder: (_, __, ___) {
        return ConfirmCustomDialog(
          title: title,
          text: text,
          actions: actions,
        );
      },
      context: context,
      transitionBuilder: (context, a1, a2, child) {
        double curve = Curves.easeInOut.transform(a1.value);

        return Transform.scale(scale: curve, child: child);
      },
      transitionDuration: const Duration(milliseconds: 200),
    );
  }
}
