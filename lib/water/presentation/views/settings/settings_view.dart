import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/themes.dart';
import '../../controllers/water_settings_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .025),
      child: ListView(
        children: [
          InkWell(
            onTap: () async {
              await context.read<WaterSettingsController>().init();

              Navigator.pushNamed(context, '/waterSettings');
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: Spacing.small2, horizontal: Spacing.small2),
              child: Row(
                children: [
                  Icon(CupertinoIcons.gear),
                  SizedBox(width: Spacing.small3),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Configurar seus dados',
                        softWrap: true,
                        maxLines: 2,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: FontSize.small1),
                      ),
                      Text(
                        softWrap: true,
                        maxLines: 2,
                        'Peso, horário de sono, frequência de treino',
                        style: TextStyle(fontSize: FontSize.small),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
