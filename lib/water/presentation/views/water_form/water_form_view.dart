import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/water_controller.dart';
import '../../utils/dialogs.dart';
import '../../utils/snackbar_message.dart';
import '../../widgets/buttons/button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
  late final ValueNotifier<bool> _showReloadButton;

  @override
  void initState() {
    super.initState();

    final controller = context.read<WaterFormController>();

    _showGoBackButton = ValueNotifier(false);
    _showFinishButton = ValueNotifier(false);
    _showReloadButton = ValueNotifier(false);

    controller.pageController.addListener(() {
      _showGoBackButton.value = controller.pageController.page! > 0.5;
      _showFinishButton.value = controller.pageController.page! == controller.pages.length - 1;
      _showReloadButton.value = controller.pageController.page! >= controller.pages.length - 1.5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WaterFormController>(
      builder: (context, controller, _) {
        return Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ValueListenableBuilder(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  controller.goBack();
                                },
                                icon: const Icon(Icons.arrow_back),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  ValueListenableBuilder(
                    valueListenable: _showReloadButton,
                    builder: (context, showReloadButton, _) {
                      return Visibility(
                        visible: showReloadButton,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 250),
                          opacity: showReloadButton ? 1 : 0,
                          child: IconButton(
                            tooltip: 'Reiniciar dados',
                            onPressed: () async {
                              await Dialogs.confirm(
                                title: 'Reiniciar dados?',
                                text: 'Somente as alterações feitas nesta tela serão perdidas.',
                                cancelText: 'Cancelar',
                                confirmText: 'Sim, reiniciar',
                                onYes: () {
                                  controller.reloadData();
                                  Navigator.pop(context);
                                },
                                onNo: () {
                                  Navigator.pop(context);
                                },
                                context: context,
                              );
                            },
                            icon: const Icon(
                              Icons.restart_alt,
                              size: Spacing.medium2,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
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
                          children: controller.pages,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(top: Spacing.small),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SmoothPageIndicator(
                    controller: controller.pageController,
                    count: controller.pages.length,
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
                                      await Dialogs.confirm(
                                          context: context,
                                          text: 'Você poderá mudar essas alterações no futuro.',
                                          title: 'Deseja finalizar?',
                                          onNo: () => Navigator.pop(context),
                                          onYes: () {
                                            controller.saveData(context).then((value) async {
                                              value.fold((failure) {
                                                SnackBarMessage.error(failure, context: context);
                                              }, (success) {
                                                context.read<WaterController>().init().whenComplete(() {
                                                  Navigator.pushNamed(context, '/home');
                                                });
                                              });
                                            });
                                          });
                                    },
                                    text: 'Finalizar',
                                    suffixIcon: null,
                                  )
                                : _Button(
                                    onPressed: () {
                                      controller.goNext();
                                    },
                                    text: 'Próximo',
                                    suffixIcon: Icons.arrow_forward_ios_rounded,
                                  ),
                          );
                        }),
                  ),
                ],
              ),
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
