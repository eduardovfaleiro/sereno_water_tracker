import 'package:dartz/dartz.dart';

import '../../../error/failures.dart';

abstract class RegisterGetIt {
  Either<Failure, void> call();
}
