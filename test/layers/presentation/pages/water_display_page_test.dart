import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:sereno_clean_architecture_solid/core/core.dart';
import 'package:sereno_clean_architecture_solid/layers/presentation/controllers/water_display_controller.dart';
import 'package:sereno_clean_architecture_solid/layers/presentation/pages/water/water_display_page.dart';

class BuildContextFake extends Fake implements BuildContext {}

class MockWaterDisplayController extends Mock implements WaterDisplayController {}

Widget _getMaterialApp(Widget child) {
  ChangeNotifierProvider(create: (_) => ChangeNotifier());

  return MaterialApp(
    home: ChangeNotifierProvider<WaterDisplayController>(
      create: (_) => MockWaterDisplayController(),
      child: child,
    ),
  );
}

void main() {
  late MockWaterDisplayController mockWaterDisplayController;

  setUp(() {
    mockWaterDisplayController = MockWaterDisplayController();
  });

  setUpAll(() {
    registerFallbackValue(BuildContextFake());
  });

  group('amountOfWaterDrankTodayWidget', () {
    testWidgets('Should display 1000 ml if call to repository is successful', (widgetTester) async {
      var amountOfWaterDrankToday = Future.value(right<Failure, int>(1000));

      when(
        () => mockWaterDisplayController.getAmountOfWaterDrankToday(any()),
      ).thenAnswer((_) async => amountOfWaterDrankToday);

      await widgetTester.pumpWidget(_getMaterialApp(const WaterDisplayPage()));

      var amountOfWaterDrankTodayFinder = find.textContaining('1000');
      expect(amountOfWaterDrankTodayFinder, findsOneWidget);
    });
  });
}
