abstract interface class DailyGoalDataSource {
  Future<int> get();
  Future<int> update();
  Future<void> create(int amount);
}
