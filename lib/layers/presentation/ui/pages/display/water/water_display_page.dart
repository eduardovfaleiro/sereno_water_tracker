import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../../../core/theme/themes_wrap.dart';
import '../../../../controllers/water_display_controller.dart';

class WaterDisplayPage extends StatelessWidget {
  WaterDisplayPage({super.key});

  final WaterDisplayController _waterDisplayController = GetIt.I.get<WaterDisplayController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Water')),
      body: Padding(
        padding: Sizes.pagePadding,
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            Row(
                // children: [Text('Água bebida hoje'), Text(_waterDisplayController.getWaterDrankToday())],
                )
          ],
        ),
      ),
    );
  }
}
