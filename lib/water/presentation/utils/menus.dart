import 'package:flutter/material.dart';

import '../../../core/theme/themes.dart';
import '../widgets/menu/popup_menu_button_item.dart';
import '../widgets/menu/popup_menu_wrap.dart';

abstract class Menus {
  static Future<void> buttons({
    required GlobalKey key,
    required List<PopupMenuEntry> items,
    bool fitButton = false,
    required BuildContext context,
  }) async {
    RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
    Offset offset = box.localToGlobal(Offset.zero);

    double y = offset.dy;
    double x = offset.dx;
    double h = box.size.height;

    await showMenu(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Sizes.borderRadius)),
      clipBehavior: Clip.hardEdge,
      constraints: const BoxConstraints.tightForFinite(),
      context: context,
      position: RelativeRect.fromLTRB(x, y - h + Spacing.normal, x, y),
      items: [PopupMenuWrap(items: items)],
    );
  }

  static Future<void> normal({
    required GlobalKey key,
    required List<PopupMenuEntry> items,
    required BuildContext context,
  }) async {
    RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
    Offset offset = box.localToGlobal(Offset.zero);

    double y = offset.dy;
    double x = offset.dx;
    double h = box.size.height;

    await showMenu(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Sizes.borderRadius)),
      clipBehavior: Clip.hardEdge,
      constraints: const BoxConstraints.tightForFinite(),
      context: context,
      position: RelativeRect.fromLTRB(x, y + h + Spacing.small, x, y),
      items: items,
    );
  }

  static Future<void> button({
    required GlobalKey key,
    required VoidCallback onTap,
    required Text label,
    required Icon icon,
    required BuildContext context,
  }) async {
    final RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
    final Offset position = box.localToGlobal(Offset.zero);

    final double y = position.dy;
    final double x = position.dx;
    final double h = box.size.height;
    final double w = box.size.width;

    await showMenu(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.borderRadius),
        ),
        clipBehavior: Clip.hardEdge,
        constraints: BoxConstraints.tightForFinite(width: w),
        context: context,
        position: RelativeRect.fromLTRB(x, y - h + Spacing.normal, x, y),
        items: [
          PopupMenuButtonItem(
            onTap: onTap,
            label: label,
            icon: icon,
            borderRadius: BorderRadius.circular(Sizes.borderRadius),
          )
        ]);
  }
}
