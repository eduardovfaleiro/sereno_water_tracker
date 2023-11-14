import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../core/initializers/hive_initializer.dart';
import '../../../../core/theme/themes.dart';
import '../../../domain/services/notification_service.dart';
import '../../../domain/services/reset_data_with_timer_service.dart';
import '../../controllers/drink_history_controller.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/water_settings_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      await getIt<HiveInitializer>().startDrinkHistoryReset();
      await getIt<HiveInitializer>().generateContainersIfEmpty();

      getIt<ResetDataWithTimerService>().startWater();
      await getIt<NotificationService>().initialize();

      await getIt<HiveInitializer>().setListenersReminders();

      context.read<WaterSettingsController>().init();
      getIt<DrinkHistoryController>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, controller, _) {
        return Scaffold(
          body: PageView(
            controller: controller.pageController,
            onPageChanged: (page) {
              setState(() {
                controller.selectedPage = page;
              });
            },
            children: controller.pages,
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(.1),
                )
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .12,
                  vertical: Spacing.small,
                ),
                child: GNav(
                  rippleColor: MyColors.darkGrey2,
                  hoverColor: MyColors.darkGrey2,
                  gap: 4,
                  backgroundColor: Colors.black,
                  activeColor: MyColors.lightGrey,
                  iconSize: 24,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: const Duration(milliseconds: 400),
                  color: MyColors.lightGrey,
                  tabBackgroundColor: MyColors.darkGrey,
                  tabs: const [
                    GButton(icon: Icons.water_drop_outlined),
                    GButton(icon: Icons.history_sharp),
                    GButton(icon: CupertinoIcons.bell),
                    GButton(icon: CupertinoIcons.gear_alt),
                  ],
                  selectedIndex: controller.selectedPage,
                  onTabChange: (index) {
                    setState(() {
                      controller.pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                      );
                    });
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
