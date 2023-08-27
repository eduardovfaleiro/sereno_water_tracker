import 'package:flutter/material.dart';

import '../views/reminder/reminder_view.dart';
import '../views/settings/water_settings_view.dart';
import '../views/water/water_view.dart';

class HomeController extends ChangeNotifier {
  late PageController pageController;
  late List<Widget> pages;
  late int selectedPage;

  bool isLoading = false;

  Future<void> init() async {
    isLoading = true;

    selectedPage = 0;
    pageController = PageController();
    pages = [
      const WaterView(),
      const WaterSettingsView(),
      const ReminderView(),
    ];

    isLoading = false;
  }
}
