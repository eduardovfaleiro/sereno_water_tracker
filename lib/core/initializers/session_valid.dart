import '../../water/domain/usecases/validate_session_usecase.dart';
import '../core.dart';

abstract class SessionValid {
  static Future<bool> check() async {
    return await getResult(getIt<ValidateSessionUseCase>().call()) is! Failure;
  }
}
