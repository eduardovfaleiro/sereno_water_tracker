import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/layers/data/datasources/weight_datasource.dart';
import 'package:sereno_clean_architecture_solid/layers/data/repositories/weight_repository_imp.dart';

class MockWeightDataSource extends Mock implements WeightDataSource {}

void main() {
  late MockWeightDataSource mockWeightDataSource;
  late WeightRepositoryImp repository;

  setUp(() {
    mockWeightDataSource = MockWeightDataSource();
    repository = WeightRepositoryImp(mockWeightDataSource);
  });

  group('update', () {
    var weight = 75.0;

    test('Should call the datasource and succeed', () async {
      // arrange
      when(() => mockWeightDataSource.update(any())).thenAnswer((_) async {});

      // act
      var result = await repository.update(weight);

      // assert
      verify(() => repository.update(weight));
      expect(result, isA<Right>());
    });
  });
}
