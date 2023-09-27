// ignore_for_file: constant_identifier_names, non_constant_identifier_names

part of core;

// Boxes
const String WATER = 'water';
const String WATER_CONTAINER = 'waterContainer';
const String USER = 'user';

// Keys
const String WATER_DRANK_TODAY = 'waterDrankToday';
const String TIMES_TO_DRINK = 'timesToDrink';
const String DAILY_DRINKING_GOAL = 'dailyDrinkingGoal';
const String DAILY_DRINKING_FREQUENCY = 'dailyDrinkingFrequency';
const String WEEKLY_WORKOUT_DAYS = 'weeklyWorkoutDays';
const String WEIGHT = 'weight';
const String SLEEPTIME = 'sleeptime';
const String WAKE_UP_TIME = 'wakeUpTime';
const String LAST_WATER_DRANK_TODAY_RESET = 'lastWaterDrankTodayReset';
const String WATER_PER_DRINK = 'waterPerDrink';

// Default
const int DEFAULT_WEIGHT = 70;
const int DEFAULT_WEEKLY_WORKOUT_DAYS = 0;
const int DEFAULT_DAILY_DRINKING_FREQUENCY = 5;
const TimeOfDay DEFAULT_WAKE_UP_TIME = TimeOfDay(hour: 6, minute: 0);
const TimeOfDay DEFAULT_SLEEPTIME = TimeOfDay(hour: 23, minute: 0);

// Utils

const String LOCALE = 'pt_BR';
const int DECIMALS = 1;
const int DAYS_IN_A_WEEK = 7;
const int MAX_DAILY_DRINKING_FREQUENCY = 10;
const int MAX_WEIGHT = 200;
const int MIN_WEIGHT = 1;
const int MIN_WATER_DRANK_TODAY = 0;
const int MIN_DAILY_DRINKING_FREQUENCY = 1;
const int MIN_DAILY_DRINKING_GOAL = 1;
const String ADD_WATER_ACTION_KEY = 'addWater';

final GetIt getIt = GetIt.I;

const List<String> CONTAINER_ASSETS = ['cup.svg', 'bottle.svg', 'cup_of_tea.svg', 'gallon.svg'];
