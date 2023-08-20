import 'package:flutter/material.dart';

import '../../../core/core.dart';

abstract class SnackBarMessage {
  static void undo({
    required BuildContext context,
    required String text,
    required VoidCallback onPressed,
  }) async {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(text),
          action: SnackBarAction(
            label: 'Desfazer',
            onPressed: onPressed,
          )),
    );
  }

  static void normal({
    required BuildContext context,
    required String text,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  static void error(Failure failure, {required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(failure.message),
      ),
    );
  }
}
