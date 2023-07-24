// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/themes.dart';
import '../../utils/dialogs.dart';
import 'icon_picker.dart';

class IconPickerField extends StatefulWidget implements IconPicker {
  @override
  final IconData? selectedIcon;

  @override
  final List<IconData> icons;

  @override
  final Function(IconData?) onOk;

  const IconPickerField({
    Key? key,
    this.selectedIcon,
    required this.icons,
    required this.onOk,
  }) : super(key: key);

  @override
  State<IconPickerField> createState() => _IconPickerFieldState();
}

class _IconPickerFieldState extends State<IconPickerField> {
  final IconData _defaultIcon = CommunityMaterialIcons.cup_water;
  late IconData _selectedIcon;

  @override
  void initState() {
    super.initState();

    _selectedIcon = widget.selectedIcon ?? _defaultIcon;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Dialogs.normal(
          context: context,
          child: IconPicker(
              icons: widget.icons,
              selectedIcon: _selectedIcon,
              onOk: (selectedIcon) {
                setState(() {
                  _selectedIcon = selectedIcon ?? _defaultIcon;

                  widget.onOk(selectedIcon);
                });
              }),
        );
      },
      child: Container(
        width: double.infinity,
        height: Spacing.huge3,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: MyColors.darkGrey1,
          borderRadius: BorderRadius.circular(Sizes.borderRadius),
        ),
        padding: const EdgeInsets.symmetric(vertical: Spacing.small1, horizontal: Spacing.small2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Select icon',
              style: TextStyle(fontSize: FontSize.small2),
            ),
            Icon(_selectedIcon, color: MyColors.lightGrey),
          ],
        ),
      ),
    );
  }
}
