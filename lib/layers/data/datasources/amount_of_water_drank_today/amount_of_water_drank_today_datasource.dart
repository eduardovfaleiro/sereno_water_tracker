abstract interface class AmountOfWaterDrankTodayDataSource {
  Future<int> get();
  Future<int> put(int amount);
}
