import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sereno_clean_architecture_solid/layers/data/repositories/create_water_container_repository_imp.dart';
import 'package:sereno_clean_architecture_solid/layers/domain/usecases/water_container/create_water_container/create_water_container_usecase_imp.dart';

import 'create_water_container_usecase_test.mocks.dart';

abstract class GetApplicationDocumentsDirectory {
  Future<Directory> call();
}

@GenerateNiceMocks([MockSpec<HiveInterface>(), MockSpec<GetApplicationDocumentsDirectory>()])
void main() {
  test('Should return a Box', () async {
    var mockHive = MockHiveInterface();
    var mockGetApplicationDocumentsDirectory = MockGetApplicationDocumentsDirectory();

    when(mockGetApplicationDocumentsDirectory()).thenAnswer(
      (_) async => Directory('/data/user/0/com.example.sereno_clean_architecture_solid/app_flutter'),
    );

    Directory directory = await mockGetApplicationDocumentsDirectory();

    await mockHive.initFlutter(directory.path);

    var useCase = CreateWaterContainerUseCaseImp(CreateWaterContainerRepositoryImp());

    expect(useCase(), isA<Future<Box<dynamic>>>());
  });
}
