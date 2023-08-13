import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/functions/validate_session.dart';
import 'core/init_functions/init_app.dart';
import 'sereno/sereno_view.dart';
import 'water/domain/entities/user_entity.dart';
import 'water/presentation/controllers/water_container_controller.dart';
import 'water/presentation/controllers/water_controller.dart';
import 'water/presentation/controllers/water_form_controller.dart';

import 'core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initApp();
  bool isSessionValid = await validateSession();

  if (isSessionValid) {
    await getIt<WaterController>().init();
  } else {
    await getIt<WaterFormController>().init(
      userEntity: UserEntity.normal(),
      dailyDrinkingFrequency: DEFAULT_DAILY_DRINKING_FREQUENCY,
    );
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<WaterFormController>(
          create: (context) => getIt<WaterFormController>(),
        ),
        ChangeNotifierProvider<WaterController>(
          create: (context) => getIt<WaterController>(),
        ),
        ChangeNotifierProvider<WaterContainerController>(
          create: (context) => getIt<WaterContainerController>(),
        ),
      ],
      child: SerenoView(isSessionValid: isSessionValid),
    ),
  );
}
