import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/repositories/water_container/create_water_container_repository.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/usecases/water_container/create_water_container/create_water_container_usecase_imp.dart';

import 'create_water_container_usecase_test.mocks.dart';

abstract class GetApplicationDocumentsDirectory {
  Future<Directory> call();
}

@GenerateNiceMocks([
  MockSpec<CreateWaterContainerRepository>(),
  MockSpec<Box>(),
])
void main() {
  test('Should return a Box', () async {
    var repository = MockCreateWaterContainerRepository();

    when(repository()).thenAnswer((_) async => MockBox());

    var useCase = CreateWaterContainerUseCaseImp(repository);

    expect(useCase(), isA<Future<Box<dynamic>>>());
  });
}
