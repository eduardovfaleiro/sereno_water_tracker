import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/themes.dart';
import '../buttons/button.dart';

class SvgPicker extends StatefulWidget {
  final String? selectedSvg;
  final List<String> svgs;
  final Function(String?) onOk;

  const SvgPicker({super.key, this.selectedSvg, required this.svgs, required this.onOk});

  @override
  State<SvgPicker> createState() => _SvgPickerState();
}

class _SvgPickerState extends State<SvgPicker> {
  String? _selectedSvg;

  @override
  void initState() {
    super.initState();

    _selectedSvg ??= widget.selectedSvg;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // icon: const Icon(CommunityMaterialIcons.shape_polygon_plus, size: Spacing.medium2),
      title: const Align(
        child: Text(
          'Selecione o ícone',
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
          spacing: Spacing.small2,
          children: List.generate(
            widget.svgs.length,
            (index) {
              String svg = widget.svgs[index];

              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedSvg = svg;
                  });
                },
                borderRadius: BorderRadius.circular(Sizes.borderRadius),
                child: (_selectedSvg == svg)
                    ? Ink(
                        padding: const EdgeInsets.all(Spacing.small1),
                        decoration: BoxDecoration(
                          color: MyColors.lightBlue,
                          borderRadius: BorderRadius.circular(Sizes.borderRadius),
                        ),
                        child: SvgPicture.asset(
                          'assets/images/$svg',
                          width: Spacing.medium2,
                          height: Spacing.medium2,
                          colorFilter: const ColorFilter.mode(MyColors.darkBlue, BlendMode.srcIn),
                        ),
                      )
                    : Ink(
                        padding: const EdgeInsets.all(Spacing.small1),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 34, 34, 39),
                          borderRadius: BorderRadius.circular(Spacing.small3),
                        ),
                        child: SvgPicture.asset(
                          'assets/images/$svg',
                          width: Spacing.medium2,
                          height: Spacing.medium2,
                          colorFilter: const ColorFilter.mode(MyColors.lightGrey, BlendMode.srcIn),
                        ),
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
            widget.onOk(_selectedSvg);

            Navigator.pop(context);
          }),
        ),
      ],
    );
  }
}
