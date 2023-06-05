import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';

import '../../../core.dart';
import 'register_get_it.dart';

class RegisterFactoryImp<T extends Object> implements RegisterGetIt {
  final T Function() factoryFunc;

  RegisterFactoryImp(this.factoryFunc);

  @override
  Result<void> call() {
    try {
      return Right(GetIt.I.registerFactory<T>(factoryFunc));
    } catch (e) {
      return Left(GetItFailure('Error while registering factory.'));
    }
  }
}
