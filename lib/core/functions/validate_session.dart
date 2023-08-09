import '../../water/domain/usecases/validate_session_usecase.dart';
import '../core.dart';

Future<bool> validateSession() async {
  final validateSessionUseCase = getIt<ValidateSessionUseCase>();

  final validateResult = await getResult(validateSessionUseCase());

  return validateResult is! Failure;
}
