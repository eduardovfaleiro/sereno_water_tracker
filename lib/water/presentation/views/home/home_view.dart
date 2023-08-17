import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../water/water_view.dart';
import '../water_form/water_form_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<Widget> _pages = [
    const WaterView(),
    const WaterFormView(),
  ];

  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
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
