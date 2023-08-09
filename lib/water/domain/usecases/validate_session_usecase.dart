// ignore_for_file: unnecessary_null_comparison

import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/repositories/water_repository.dart';

abstract class ValidateSessionUseCase {
  Future<Result<void>> call();
}

class ValidateSessionUseCaseImp implements ValidateSessionUseCase {
  final UserRepository _userRepository;
  final WaterRepository _waterRepository;

  ValidateSessionUseCaseImp(this._userRepository, this._waterRepository);

  @override
  Future<Result<void>> call() async {
    try {
      final userResult = await getResult(_userRepository.getUser());
      final waterDataResult = await getResult(_waterRepository.getWaterData());

      if (userResult is Failure) return Left(userResult);
      if (waterDataResult is Failure) return Left(waterDataResult);

      return const Right(null);
    } on TypeError catch (e) {
      return Left(ValidationFailure(e.toString()));
    }
  }
}
