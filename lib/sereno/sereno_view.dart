import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/core.dart';
import '../core/theme/themes.dart';
import '../water/domain/entities/user_entity.dart';
import '../water/presentation/controllers/water_form_controller.dart';
import '../water/presentation/views/home/home_view.dart';
import '../water/presentation/views/settings/settings_view.dart';
import '../water/presentation/views/settings/water_settings_view.dart';
import '../water/presentation/views/water/water_view.dart';
import '../water/presentation/views/water_form/water_form_view.dart';

class SerenoView extends StatefulWidget {
  final bool isSessionValid;

  const SerenoView({super.key, required this.isSessionValid});

  @override
  State<SerenoView> createState() => _SerenoViewState();
}

class _SerenoViewState extends State<SerenoView> {
  @override
  void initState() {
    super.initState();

    if (_initialRoute == '/waterForm') {
      context.read<WaterFormController>().init(
            userEntity: UserEntity.normal(),
            dailyDrinkingFrequency: DEFAULT_DAILY_DRINKING_FREQUENCY,
          );
    }
  }

  String get _initialRoute {
    if (widget.isSessionValid) {
      return '/home';
    }

    return '/waterForm';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: _initialRoute,
      routes: {
        '/waterForm': (context) => const WaterFormView(),
        '/water': (_) => const WaterView(),
        '/home': (_) => const HomeView(),
        '/settings': (_) => const SettingsView(),
        '/waterSettings': (_) => const WaterSettingsView(),
      },
      debugShowCheckedModeBanner: false,
      theme: Themes.dark,
    );
  }
}
