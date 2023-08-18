import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../settings/settings_view.dart';
import '../water/water_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<Widget> _pages = [
    const WaterView(),
    const SettingsView(),
  ];

  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: (index) {
          setState(() {
            _selectedPage = index;
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
        ],
      ),
    );
  }
}
