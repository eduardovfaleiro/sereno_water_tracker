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
      enableDrag: true,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(
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
      },
    );
  }

  static Future<void> items({
    required List<BottomSheetItemTile> items,
    required BuildContext context,
  }) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(bottom: Spacing.medium),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...List.generate(items.length, (index) {
                if (items[index] is BottomSheetItemTileSimple) {
                  final itemTile = items[index] as BottomSheetItemTileSimple;

                  return InkWell(
                    onTap: () => itemTile.onTap(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Spacing.small3,
                        vertical: Spacing.small2,
                      ),
                      child: Row(
                        children: [
                          itemTile.icon,
                          const SizedBox(width: Spacing.small1),
                          Text(itemTile.label),
                        ],
                      ),
                    ),
                  );
                } else if (items[index] is BottomSheetItemTileCustomChild) {
                  final itemTile = items[index] as BottomSheetItemTileCustomChild;

                  return itemTile.child;
                }

                throw TypeError();
              }),
            ],
          ),
        );
      },
    );
  }
}

abstract class BottomSheetItemTile {}

class BottomSheetItemTileSimple implements BottomSheetItemTile {
  final VoidCallback onTap;
  final Icon icon;
  final String label;

  BottomSheetItemTileSimple({
    required this.onTap,
    required this.icon,
    required this.label,
  });
}

class BottomSheetItemTileCustomChild implements BottomSheetItemTile {
  final Widget child;

  BottomSheetItemTileCustomChild({required this.child});
}
