

// class UserRepositoryImp implements UserRepository {
//   final UserDataSource _dataSource;

//   UserRepositoryImp(this._dataSource);

//   @override
//   Future<Result<void>> updateSleepTime(TimeOfDay sleepTime) async {
//     try {
//       return Right(await _dataSource.updateSleepTime(sleepTime));
//     } catch (error) {
//       return Left(CacheFailure(error.toString()));
//     }
//   }

//   @override
//   Future<Result<void>> updateTimesToDrinkPerDay(int timesToDrinkPerDay) {
//     throw UnimplementedError();
//   }

//   @override
//   Future<Result<void>> updateWakeUpTime(TimeOfDay wakeUpTime) {
//     throw UnimplementedError();
//   }

//   @override
//   Future<Result<void>> updateWeeklyWorkoutDays(int weeklyWorkoutDays) {
//     throw UnimplementedError();
//   }

//   @override
//   Future<Result<void>> updateWeight(double weight) {
//     throw UnimplementedError();
//   }
// }
