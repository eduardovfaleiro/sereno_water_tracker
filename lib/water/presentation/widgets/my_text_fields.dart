import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DigitOnlyTextField extends StatelessWidget {
  final String label;
  final String? suffix;
  final bool autofocus;
  final Function(int) onChanged;
  final String? Function(String?)? validator;

  const DigitOnlyTextField({
    super.key,
    required this.label,
    this.suffix,
    required this.autofocus,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      keyboardType: const TextInputType.numberWithOptions(),
      keyboardAppearance: Brightness.dark,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (validator != null) {
          return validator!(value);
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        suffixText: suffix,
      ),
      maxLength: 18,
      onChanged: (value) async {
        if (value.isEmpty) {
          await onChanged(0);
          return;
        }

        await onChanged(int.parse(value));
      },
    );
  }
}
