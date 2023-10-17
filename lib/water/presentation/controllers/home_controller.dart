import 'package:flutter/material.dart';

import '../views/drink_history/drink_history_view.dart';
import '../views/reminder/reminder_view.dart';
import '../views/water_settings/water_settings_view.dart';
import '../views/water/water_view.dart';

class HomeController extends ChangeNotifier {
  late PageController pageController;

  final pages = <Widget>[
    const WaterView(),
    const DrinkHistoryView(),
    const ReminderView(),
    const WaterSettingsView(),
  ];

  int selectedPage = 0;
  bool isLoading = false;

  Future<void> init() async {
    isLoading = true;

    pageController = PageController();

    isLoading = false;
  }
}
