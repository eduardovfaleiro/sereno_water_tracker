// ignore_for_file: must_be_immutable

library water_view;

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../../core/core.dart';
import '../../../../../core/theme/themes.dart';
import '../../../domain/entities/water_container_entity.dart';
import '../../controllers/water_controller.dart';
import '../../utils/dialogs.dart';
import '../../utils/menus.dart';
import '../../utils/snackbar_message.dart';
import '../../view_models/water_container_view_model.dart';
import '../../view_models/water_view_model.dart';
import '../../widgets/button.dart';
import '../../widgets/circular_button.dart';
import '../../widgets/icon_picker/icon_picker_field.dart';
import '../../widgets/menu/popup_menu_button_item.dart';

part 'components/add_custom_water_amount_widget.dart';
part 'components/create_water_container_widget.dart';
part 'components/duration_widget.dart';
part 'components/progress_bar_widget.dart';
part 'components/remove_custom_water_amount_widget.dart';
part 'components/water_container_widget.dart';
part 'components/water_data_widget.dart';

class WaterView extends StatelessWidget {
  WaterView({super.key});

  final WaterController controller = getIt<WaterController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          top: -650,
          child: Image(
            image: AssetImage('assets/images/water_background.png'),
          ),
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
          body: Consumer<WaterViewModel>(
            builder: (context, waterViewModel, _) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: Spacing.small1,
                  right: Spacing.small1,
                  top: Spacing.huge16,
                  bottom: Spacing.small3,
                ),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(height: Spacing.small3),
                    Container(
                      padding: const EdgeInsets.all(Spacing.normal),
                      decoration: BoxDecoration(
                        color: MyColors.darkGrey,
                        borderRadius: BorderRadius.circular(Sizes.borderRadius),
                      ),
                      child: Column(
                        children: [
                          WaterDataWidget(
                            'Water drank today',
                            controller.data.amountDrankToday,
                          ),
                          const SizedBox(height: Spacing.small3),
                          ProgressBarWidget(waterViewModel.getDailyGoalCompletedPercentage()),
                          const SizedBox(height: Spacing.small3),
                          WaterDataWidget('Daily goal', controller.data.dailyGoal),
                        ],
                      ),
                    ),
                    const SizedBox(height: Spacing.small3),
                    Container(
                      padding: const EdgeInsets.all(Spacing.normal),
                      decoration: BoxDecoration(
                        color: MyColors.darkGrey,
                        borderRadius: BorderRadius.circular(Sizes.borderRadius),
                      ),
                      child: const DurationWidget('Drink again in', Duration(hours: 3)),
                    ),
                    const SizedBox(height: Spacing.medium),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: Spacing.normal),
                      alignment: Alignment.topLeft,
                      child: const AnimatedSwitcher(
                        duration: Duration(seconds: 1),
                        child: WaterContainerWidget(),
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
