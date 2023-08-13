import 'package:flutter/material.dart';

import '../../../core/theme/themes.dart';

abstract class BottomSheets {
  static Future<void> normal({
    required BuildContext context,
    required String title,
    required Widget content,
  }) async {
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: false,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: Spacing.small2,
                    left: Spacing.small2,
                    right: Spacing.small2,
                  ),
                  child: Align(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: FontSize.small2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                content
              ],
            ),
          );
        });
  }
}
