import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    context.read<HomeController>().init();
    context.read<WaterSettingsController>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, controller, _) {
        return Scaffold(
          body: PageView(
            controller: controller.pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (page) {
              setState(() {
                controller.selectedPage = page;
              });
            },
            children: controller.pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.selectedPage,
            onTap: (index) {
              setState(() {
                controller.pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                );
              });
            },
            items: const [
              BottomNavigationBarItem(
                label: 'Água',
                icon: Icon(CupertinoIcons.drop),
                activeIcon: Icon(CupertinoIcons.drop_fill),
              ),
              BottomNavigationBarItem(
                label: 'Configurações',
                icon: Icon(CupertinoIcons.gear),
                activeIcon: Icon(CupertinoIcons.gear_alt_fill),
              ),
              BottomNavigationBarItem(
                label: 'Notificações',
                icon: Icon(CupertinoIcons.bell),
                activeIcon: Icon(CupertinoIcons.bell_fill),
              ),
            ],
          ),
        );
      },
    );
  }
}
