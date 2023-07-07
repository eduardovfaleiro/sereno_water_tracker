import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../core/theme/themes.dart';
import '../view_models/water_view_model.dart';
import '../widgets/circular_button.dart';

class WaterDisplayView extends StatelessWidget {
  const WaterDisplayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          top: -650,
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
          body: Consumer<WaterViewModel>(
            builder: (context, waterViewModel, _) {
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
                    WaterDataWidget(
                      'Water drank today',
                      waterViewModel.getAmountDrankToday(),
                    ),
                    const SizedBox(height: Spacing.small2),
                    ProgressBar(waterViewModel.getDailyGoalCompletedPercentage()),
                    const SizedBox(height: Spacing.small2),
                    WaterDataWidget('Daily goal', waterViewModel.getDailyDrinkingGoal()),
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
                            // onTap: waterViewModel.createWaterContainer(waterContainerEntity),
                            color: Color(0xff4E9CC8),
                            label: Text('250 $VOLUME_UNIT_M', style: TextStyle(color: Colors.white)),
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

class WaterDataWidget extends StatelessWidget {
  final String text;
  final Future<Result<int>> value;

  const WaterDataWidget(this.text, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text),
        FutureBuilder(
          future: value,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading...');
            }

            return snapshot.data!.fold(
              (failure) {
                return const Text('Unavailable');
              },
              (amountOfWaterDrankToday) {
                return Text(
                  '$amountOfWaterDrankToday ml',
                  style: const TextStyle(fontWeight: FontWeight.w500, color: Color(0xFF4E9CC8)),
                );
              },
            );
          },
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

class ProgressBar extends StatefulWidget {
  final Future<Result<double>> value;

  const ProgressBar(this.value, {super.key});

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        var percentage = snapshot.data as Result<double>?;

        if (snapshot.data == null) {
          return const LinearProgressIndicator(value: 0);
        }

        return LinearProgressIndicator(
          value: percentage!.fold((failure) => 0, (success) => success),
        );
      },
    );
  }
}
