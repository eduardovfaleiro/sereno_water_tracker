part of core;

abstract class ValidationFailures {
  static final wakeUpTime = ValidationFailure("Wake up time shouldn't be empty.");
  static final sleepTime = ValidationFailure("Sleep time shouldn't be empty.");
}
