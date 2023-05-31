import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/theme/themes.dart';
import '../../../controllers/water_display_controller.dart';
import '../../widgets/buttons/circular_button.dart';

class WaterDisplayPage extends StatelessWidget {
  const WaterDisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          top: -500,
          child: Image(image: AssetImage('assets/images/water_background.jpg')),
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment(0, 0.05),
              colors: [Colors.transparent, Color.fromARGB(255, 0, 0, 0), Color.fromARGB(255, 0, 0, 0)],
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: Container(
            color: Colors.black,
          ),
        ),
        Scaffold(
          appBar: AppBar(title: const Text('Water')),
          body: Consumer<WaterDisplayController>(
            builder: (context, waterDisplayController, _) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: Spacing.small3,
                  right: Spacing.small3,
                  top: Spacing.huge6,
                  bottom: Spacing.small3,
                ),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Água bebida hoje'),
                        FutureBuilder(
                          future: waterDisplayController.getAmountOfWaterDrankToday(context),
                          builder: (context, snapshot) => Text(
                            snapshot.data as String? ?? '0',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Spacing.small2),
                    const LinearProgressIndicator(value: 0),
                    const SizedBox(height: Spacing.small2),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Meta diária'),
                        Text('3000 ml'),
                      ],
                    ),
                    const SizedBox(height: Spacing.medium2),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Tempo até beber novamente'),
                        Text('3h 27min'),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: Spacing.medium2),
                      alignment: Alignment.centerLeft,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return const CircularButton(
                            // onTap: waterDisplayController.createWaterContainer(waterContainerEntity),
                            color: MyColors.darkBlue,
                            label: Text('250 ml', style: TextStyle(color: Colors.white)),
                            child: Icon(CommunityMaterialIcons.cup),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class BackgroundImageWithGradient extends StatelessWidget {
  const BackgroundImageWithGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        const Positioned.fill(
          top: -500,
          child: Image(image: AssetImage('assets/images/water_background.jpg')),
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment(0, 0.05),
              colors: [Colors.transparent, Color.fromARGB(255, 0, 0, 0), Color.fromARGB(255, 0, 0, 0)],
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: Container(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
