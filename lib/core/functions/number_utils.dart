library number_utils;

import 'dart:math';

import 'package:intl/intl.dart';

import '../core.dart';

class NumberUtils {
  final num number;

  NumberUtils(this.number);

  String roundByDecimalsToString([int decimals = DECIMALS]) {
    var roundedNumber = _roundNumber(number.toDouble(), decimals);
    var formattedNumber = roundedNumber.toStringAsFixed(decimals);
    var formattedNumberBackToDouble = double.parse(formattedNumber);

    formattedNumber =
        NumberFormat.decimalPatternDigits(locale: LOCALE, decimalDigits: decimals).format(formattedNumberBackToDouble);

    return formattedNumber;
  }
}

double _roundNumber(double number, int decimals) {
  num value = pow(10.0, decimals);
  return ((number * value).round().toDouble() / value);
}
