import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/core.dart';
import '../../../../core/theme/themes.dart';
import '../../../../core/utils/number_utils.dart';
import '../../controllers/water_starter_controller.dart';

class WaterStarterPage extends StatefulWidget {
  const WaterStarterPage({super.key});

  @override
  State<WaterStarterPage> createState() => _WaterStarterPageState();
}

class _WaterStarterPageState extends State<WaterStarterPage> {
  final WaterStarterController waterStarterController = GetIt.I<WaterStarterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(Spacing.normal),
            child: ListView(
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
                            color: Color(0xff4E9CC8),
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
                InputCardWidget(
                  question: const MarkdownBody(data: "# What's your **weight**?"),
                  value: Text(
                    '${NumberUtils(waterStarterController.weight).roundByDecimalsToString()} $MASS_UNIT_K',
                    style: const TextStyle(color: Color(0xff4E9CC8), fontSize: FontSize.small1),
                  ),
                  slider: Slider(
                    max: 200,
                    value: waterStarterController.weight,
                    onChanged: (value) {
                      setState(() {
                        waterStarterController.updateWeight(value);
                      });
                    },
                  ),
                ),
                const SizedBox(height: Spacing.small3),
                InputCardWidget(
                  question: const MarkdownBody(data: '# How **often** to drink a **day**?'),
                  value: const Text('4 times', style: TextStyle(color: Color(0xff4E9CC8), fontSize: FontSize.small1)),
                  slider: Slider(
                    max: 8,
                    value: 4,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(height: Spacing.small3),
                InputCardWidget(
                  question: const MarkdownBody(data: '# How **often** do you exercise\n# a **week**?'),
                  value: const Text('4 times', style: TextStyle(color: Color(0xff4E9CC8), fontSize: FontSize.small1)),
                  slider: Slider(
                    max: 8,
                    value: 4,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.normal),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Sizes.borderRadius)),
                  padding: const EdgeInsets.symmetric(vertical: Spacing.small2),
                  backgroundColor: const Color.fromARGB(255, 138, 201, 132),
                ),
                onPressed: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Next',
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: FontSize.small2),
                            ),
                            SizedBox(width: Spacing.small),
                            Icon(Icons.arrow_forward_ios_rounded, color: Colors.black),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

class InputCardWidget extends StatefulWidget {
  final Widget question;
  final Widget value;
  final Slider slider;

  const InputCardWidget({
    super.key,
    required this.question,
    required this.value,
    required this.slider,
  });

  @override
  State<InputCardWidget> createState() => _InputCardWidgetState();
}

class _InputCardWidgetState extends State<InputCardWidget> {
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
              widget.question,
              widget.value,
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: Spacing.normal, bottom: Spacing.small2),
            child: widget.slider,
          ),
        ],
      ),
    );
  }
}
