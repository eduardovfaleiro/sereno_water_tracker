library number_utils;

import 'dart:math';

import 'package:intl/intl.dart';

import '../core.dart';

part './functions/round_number.dart';

class NumberUtils {
  final num number;

  NumberUtils(this.number);

  String roundByDecimalsToString([int decimals = DECIMALS]) {
    var roundedNumber = roundNumber(number.toDouble(), decimals);
    var formattedNumber = roundedNumber.toStringAsFixed(decimals);
    var formattedNumberBackToDouble = double.parse(formattedNumber);

    formattedNumber = NumberFormat.decimalPatternDigits(locale: LOCALE, decimalDigits: decimals).format(formattedNumberBackToDouble);

    return formattedNumber;
  }
}
