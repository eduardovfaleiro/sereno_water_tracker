import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/themes.dart';
import '../../utils/dialogs.dart';
import 'svg_picker.dart';

class SvgPickerField extends StatefulWidget implements SvgPicker {
  @override
  final String? selectedSvg;

  @override
  final List<String> svgs;

  @override
  final Function(String?) onOk;

  const SvgPickerField({
    Key? key,
    this.selectedSvg,
    required this.svgs,
    required this.onOk,
  }) : super(key: key);

  @override
  State<SvgPickerField> createState() => _SvgPickerFieldState();
}

class _SvgPickerFieldState extends State<SvgPickerField> {
  final String _defaultSvg = 'cup.svg';
  late String _selectedSvg;

  @override
  void initState() {
    super.initState();

    _selectedSvg = widget.selectedSvg ?? _defaultSvg;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Dialogs.normal(
          context: context,
          child: SvgPicker(
              svgs: widget.svgs,
              selectedSvg: _selectedSvg,
              onOk: (selectedSvg) {
                setState(() {
                  _selectedSvg = selectedSvg ?? _defaultSvg;

                  widget.onOk(_selectedSvg);
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
              'Selecione o ícone',
              style: TextStyle(fontSize: FontSize.small2),
            ),
            SvgPicture.asset(
              'assets/images/$_selectedSvg',
              height: Spacing.medium1,
              width: Spacing.medium1,
              colorFilter: const ColorFilter.mode(MyColors.lightGrey, BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }
}
