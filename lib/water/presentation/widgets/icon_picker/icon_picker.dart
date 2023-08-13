import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/themes.dart';
import '../buttons/button.dart';

class IconPicker extends StatefulWidget {
  final IconData? selectedIcon;
  final List<IconData> icons;
  final Function(IconData?) onOk;

  const IconPicker({super.key, this.selectedIcon, required this.icons, required this.onOk});

  @override
  State<IconPicker> createState() => _IconPickerState();
}

class _IconPickerState extends State<IconPicker> {
  IconData? _selectedIcon;

  @override
  void initState() {
    super.initState();

    _selectedIcon ??= widget.selectedIcon;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(CommunityMaterialIcons.image_plus, size: Spacing.medium2),
      title: const Align(
        child: Text(
          'Select an icon',
          style: TextStyle(
            fontSize: FontSize.small2,
            fontWeight: FontWeight.w500,
            color: MyColors.lightGrey,
          ),
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: Spacing.small2),
        child: Wrap(
          spacing: Spacing.small1,
          children: List.generate(
            widget.icons.length,
            (index) {
              IconData icon = widget.icons[index];

              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedIcon = icon;
                  });
                },
                borderRadius: BorderRadius.circular(Sizes.borderRadius),
                child: (_selectedIcon == icon)
                    ? Ink(
                        padding: const EdgeInsets.all(Spacing.small1),
                        decoration: BoxDecoration(
                          color: MyColors.lightBlue,
                          borderRadius: BorderRadius.circular(Sizes.borderRadius),
                        ),
                        child: Icon(widget.icons[index], size: Spacing.medium2, color: MyColors.darkBlue),
                      )
                    : Ink(
                        padding: const EdgeInsets.all(Spacing.small1),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 34, 34, 39),
                          borderRadius: BorderRadius.circular(Spacing.small3),
                        ),
                        child: Icon(widget.icons[index], size: Spacing.medium2, color: MyColors.lightGrey),
                      ),
              );
            },
          ),
        ),
      ),
      actions: [
        SizedBox(
          width: double.infinity,
          child: Button.ok(onPressed: () {
            widget.onOk(_selectedIcon);

            Navigator.pop(context);
          }),
        ),
      ],
    );
  }
}
