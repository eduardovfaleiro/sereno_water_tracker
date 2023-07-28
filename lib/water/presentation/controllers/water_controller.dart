import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../core/error/exceptions.dart';
import '../../domain/entities/water_container_entity.dart';
import '../../domain/entities/water_data_entity.dart';
import '../../domain/usecases/should_add_water_usecase.dart';
import '../utils/snackbar_message.dart';
import '../view_models/water_container_view_model.dart';
import '../view_models/water_view_model.dart';

class WaterController {
  var data = WaterDataEntity(
    amountDrankToday: 0,
    dailyGoal: 0,
    numberOfTimesToDrinkDaily: MIN_NUMBER_OF_TIMES_TO_DRINK_A_DAY,
  );

  WaterViewModel waterViewModel;

  WaterController(this.waterViewModel) {
    waterViewModel.addListener(() {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final amountDrankTodayResult = await waterViewModel.getAmountDrankToday();
    if (amountDrankTodayResult.isLeft()) return;

    final dailyGoalResult = await waterViewModel.getDailyDrinkingGoal();
    if (dailyGoalResult.isLeft()) return;

    final numberOfTimesToDrinkDailyResult = await waterViewModel.getNumberOfTimesToDrinkDaily();
    if (numberOfTimesToDrinkDailyResult.isLeft()) return;

    int amountDrankToday = amountDrankTodayResult.getOrElse(() => throw LeftException());
    int dailyGoal = dailyGoalResult.getOrElse(() => throw LeftException());
    int numberOfTimesToDrinkDaily = numberOfTimesToDrinkDailyResult.getOrElse(() => throw LeftException());

    data = WaterDataEntity(
      amountDrankToday: amountDrankToday,
      dailyGoal: dailyGoal,
      numberOfTimesToDrinkDaily: numberOfTimesToDrinkDaily,
    );
  }

  Future<void> handleContainerTap({required BuildContext context, required int amount}) async {
    final shouldAddResult = await getIt<ShouldAddWaterUseCase>().call(amount).then(
      (value) {
        return value.fold(
          (l) => l,
          (r) => r,
        );
      },
    );

    if (shouldAddResult is Failure) {
      SnackBarMessage.error(shouldAddResult, context: context);
      return;
    }

    bool shouldAdd = shouldAddResult as bool;

    if (shouldAdd) {
      getIt<WaterViewModel>().addUpAmountDrankToday(amount).then((value) {
        value.fold((l) {
          SnackBarMessage.normal(context: context, text: "Couldn't add water");
        }, (r) {
          SnackBarMessage.undo(
            context: context,
            text: 'Added $amount',
            onPressed: () {
              getIt<WaterViewModel>().removeAmountDrankToday(amount);
            },
          );
        });
      });
    }
  }

  void handleContainerDelete({required BuildContext context, required WaterContainerEntity waterContainerEntity}) {
    getIt<WaterContainerViewModel>().delete(waterContainerEntity).then((result) {
      result.fold((failure) {
        SnackBarMessage.normal(context: context, text: failure.message);
      }, (success) {
        SnackBarMessage.undo(
          context: context,
          text: 'Container deleted',
          onPressed: () {
            getIt<WaterContainerViewModel>().create(waterContainerEntity).then((result) {
              result.fold((failure) {
                SnackBarMessage.normal(context: context, text: 'Couldn\'t recreate container');
              }, (_) {});
            });
          },
        );
      });
    });
  }

  Future<void> handleContainerRemoveWaterDrank({required BuildContext context, required int amount}) async {
    Result<void> result = await getIt<WaterViewModel>().removeAmountDrankToday(amount);
    if (result is Failure) {
      SnackBarMessage.normal(context: context, text: 'Couldn\'t remove amount');
    } else {
      SnackBarMessage.undo(
        context: context,
        text: 'Removed $amount ml',
        onPressed: () {
          getIt<WaterViewModel>().addUpAmountDrankToday(amount);
        },
      );
    }
  }
}
