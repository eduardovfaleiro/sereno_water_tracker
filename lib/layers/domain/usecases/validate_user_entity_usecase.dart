import '../entities/user_entity.dart';

abstract interface class ValidateUserEntityUseCase {
  bool call(UserEntity userEntity);
}

class ValidateUserEntityUseCaseImp implements ValidateUserEntityUseCase {
  @override
  bool call(UserEntity userEntity) {
    if (userEntity.wakeUpTime == null) return false;
    if (userEntity.sleepTime == null) return false;

    return true;
  }
}
