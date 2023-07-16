import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../entities/user_entity.dart';

abstract interface class ValidateUserEntityUseCase {
  Result<void> call(UserEntity userEntity);
}

class ValidateUserEntityUseCaseImp implements ValidateUserEntityUseCase {
  @override
  Result<void> call(UserEntity userEntity) {
    if (userEntity.wakeUpTime == null) return Left(ValidationFailures.wakeUpTime);
    if (userEntity.sleepTime == null) return Left(ValidationFailures.sleepTime);

    return const Right(null);
  }
}
