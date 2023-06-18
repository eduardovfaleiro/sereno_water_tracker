import 'package:flutter_test/flutter_test.dart';
import 'package:sereno_clean_architecture_solid/core/utils/number_utils.dart';

void main() {
  group('roundByDecimalsToString', () {
    test('Should round down', () async {
      var result = NumberUtils(10.1234567).roundByDecimalsToString(2);
      expect(result, '10,12');
    });

    test('Should round up', () async {
      var result = NumberUtils(10.126789).roundByDecimalsToString(2);
      expect(result, '10,13');
    });

    test('Should turn integer into "double" (as string) with the specified number of decimals', () async {
      var result = NumberUtils(10).roundByDecimalsToString(3);
      expect(result, '10,000');
    });
  });
}
