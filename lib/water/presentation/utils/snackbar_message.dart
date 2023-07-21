import 'package:flutter/material.dart';

abstract class SnackBarMessage {
  static void undo({
    required BuildContext context,
    required String text,
    required VoidCallback onPressed,
  }) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(text),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: onPressed,
          )),
    );
  }

  static void normal({
    required BuildContext context,
    required String text,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}
