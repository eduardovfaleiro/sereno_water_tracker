part of number_utils;

double roundNumber(double number, int decimals) {
  num value = pow(10.0, decimals);
  return ((number * value).round().toDouble() / value);
}
