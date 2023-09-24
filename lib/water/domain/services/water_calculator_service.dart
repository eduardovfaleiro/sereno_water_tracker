abstract class WaterCalculatorService {
  int calculateWaterPerDrinkByCustomReminders(int dailyGoal, int remindersCount);
}

class WaterCalculatorServiceImp implements WaterCalculatorService {
  @override
  int calculateWaterPerDrinkByCustomReminders(int dailyGoal, int remindersCount) {
    double waterPerDrink = dailyGoal / remindersCount;

    return waterPerDrink.toInt();
  }
}
