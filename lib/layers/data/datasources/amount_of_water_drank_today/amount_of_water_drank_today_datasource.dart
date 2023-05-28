abstract interface class AmountOfWaterDrankTodayDataSource {
  Future<int> get();
  Future<int> update(int amount);
  Future<int> subtract(int amount);
  Future<int> addUp(int amount);
}
