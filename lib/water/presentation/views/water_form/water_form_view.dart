import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/water_controller.dart';
import '../../utils/dialogs.dart';
import '../../utils/snackbar_message.dart';
import '../../widgets/buttons/button.dart';
import '../../widgets/dialogs/confirm_dialog.dart';
import 'daily_frequency_water_form.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'weekly_workout_days_water_form.dart';
import 'weight_water_form.dart';
import 'sleep_habit_water_form.dart';

import '../../../../core/theme/themes.dart';
import '../../controllers/water_form_controller.dart';

class WaterFormView extends StatefulWidget {
  const WaterFormView({super.key});

  @override
  State<WaterFormView> createState() => _WaterFormViewState();
}

class _WaterFormViewState extends State<WaterFormView> {
  late final ValueNotifier<bool> _showGoBackButton;
  late final ValueNotifier<bool> _showFinishButton;

  @override
  void initState() {
    super.initState();

    _showGoBackButton = ValueNotifier(false);
    _showFinishButton = ValueNotifier(false);

    final controller = context.read<WaterFormController>();

    controller.pageController.addListener(() {
      _showGoBackButton.value = controller.pageController.page! > 0.5;
      _showFinishButton.value = controller.pageController.page! == _pages.length - 1;
    });
  }

  final List<Widget> _pages = [
    const WeightWaterForm(),
    const DailyFrequencyWaterForm(),
    const WeeklyWorkoutDaysWaterForm(),
    const SleepHabitWaterForm(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<WaterFormController>(
      builder: (context, controller, _) {
        return Scaffold(
            appBar: AppBar(
              title: ValueListenableBuilder(
                valueListenable: _showGoBackButton,
                builder: (context, showGoBackButton, _) {
                  return Visibility(
                    visible: showGoBackButton,
                    maintainAnimation: true,
                    maintainState: true,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 250),
                      opacity: showGoBackButton ? 1 : 0,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              controller.pageController.previousPage(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeInOutExpo,
                              );
                            },
                            icon: const Icon(Icons.arrow_back),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            body: SafeArea(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(left: Spacing.normal, right: Spacing.normal),
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.9,
                        child: PageView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: controller.pageController,
                          children: _pages,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SmoothPageIndicator(
                  controller: controller.pageController,
                  count: _pages.length,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: MyColors.lightBlue1,
                    dotColor: MyColors.darkBlue1,
                    dotHeight: Spacing.small2,
                    dotWidth: Spacing.small2,
                  ),
                ),
                const SizedBox(height: Spacing.small2),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1000),
                  padding: const EdgeInsets.symmetric(horizontal: Spacing.normal, vertical: Spacing.small1),
                  child: ValueListenableBuilder(
                      valueListenable: _showFinishButton,
                      builder: (context, showFinishButton, _) {
                        return Container(
                          child: showFinishButton
                              ? _Button(
                                  onPressed: () async {
                                    await Dialogs.normal(
                                      context: context,
                                      child: ConfirmDialog(
                                        onNo: () => Navigator.pop(context),
                                        onYes: () {
                                          controller.saveData(context).then((value) async {
                                            value.fold((failure) {
                                              SnackBarMessage.error(failure, context: context);
                                            }, (success) {
                                              SnackBarMessage.normal(
                                                  context: context, text: 'Data saved successfully!');

                                              context.read<WaterController>().init().whenComplete(() {
                                                Navigator.pushNamed(context, '/water');
                                              });
                                            });
                                          });
                                        },
                                      ),
                                    );
                                  },
                                  text: 'Finalizar',
                                  suffixIcon: null,
                                )
                              : _Button(
                                  onPressed: () {
                                    controller.pageController.nextPage(
                                      duration: const Duration(milliseconds: 250),
                                      curve: Curves.easeInOutExpo,
                                    );
                                  },
                                  text: 'Próximo',
                                  suffixIcon: Icons.arrow_forward_ios_rounded,
                                ),
                        );
                      }),
                ),
              ],
            ));
      },
    );
  }
}

class _Button extends StatelessWidget {
  final String text;
  final IconData? suffixIcon;
  final VoidCallback onPressed;

  const _Button({required this.onPressed, required this.text, required this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Button.normal(onPressed: () => onPressed(), text: text, suffixIcon: suffixIcon),
        ),
      ],
    );
  }
}
