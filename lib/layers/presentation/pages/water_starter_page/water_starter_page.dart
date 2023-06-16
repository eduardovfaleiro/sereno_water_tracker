import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/theme/themes.dart';
import '../../controllers/water_starter_controller.dart';

class WaterStarterPage extends StatelessWidget {
  const WaterStarterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Spacing.normal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LinearProgressIndicator(value: 0.5),
              const SizedBox(height: Spacing.big),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: FontSize.small3,
                    color: Color.fromARGB(255, 226, 226, 226),
                    fontWeight: FontWeight.w500,
                  ),
                  text: 'Welcome to ',
                  children: [
                    TextSpan(
                        text: 'Sereno',
                        style: TextStyle(
                          color: MyColors.blue,
                          fontWeight: FontWeight.w500,
                        )),
                    TextSpan(text: '!'),
                  ],
                ),
              ),
              const SizedBox(height: Spacing.small3),
              const Text(
                'To get started, we need some information.',
                style: TextStyle(
                  fontSize: FontSize.medium2,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 231, 231, 231),
                ),
              ),
              const SizedBox(height: Spacing.big),
              const InputCardWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class InputCardWidget extends StatefulWidget {
  const InputCardWidget({super.key});

  @override
  State<InputCardWidget> createState() => _InputCardWidgetState();
}

class _InputCardWidgetState extends State<InputCardWidget> {
  final WaterStarterController waterStarterController = GetIt.I<WaterStarterController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Spacing.small3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.borderRadius),
        color: const Color(0xff0B131B),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: FontSize.small2),
                  text: "What's your ",
                  children: [
                    TextSpan(text: 'weight', style: TextStyle(fontWeight: FontWeight.w500)),
                    TextSpan(text: '?'),
                  ],
                ),
              ),
              const Text(
                'kg',
                style: TextStyle(fontSize: FontSize.small2),
              ),
            ],
          ),
          const SizedBox(height: Spacing.medium),
          Slider(
            label: ,
            value: waterStarterController.weight,
            onChanged: (value) {
              setState(() {
                waterStarterController.updateWeight(value);
              });
            },
          ),
        ],
      ),
    );
  }
}
