import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../data/repositories/water_container_repository.dart';
import '../../data/repositories/water_repository.dart';
import '../../domain/entities/water_container_entity.dart';
import '../utils/snackbar_message.dart';

class WaterContainerController extends ChangeNotifier {
  List<WaterContainerEntity> waterContainers = [];

  final WaterContainerRepository _waterContainerRepository;
  final WaterRepository _waterRepository;

  WaterContainerController(this._waterContainerRepository, this._waterRepository);

  Future<void> init() async {
    final waterContainers = await getResult(_waterContainerRepository.getAll());
    if (waterContainers is Failure) throw Exception();

    this.waterContainers = waterContainers;
    notifyListeners();
  }

  Future<void> add(WaterContainerEntity waterContainerEntity) async {
    final addContainerResult = await getResult(_waterContainerRepository.add(waterContainerEntity));
    if (addContainerResult is Failure) throw Exception();

    waterContainers.add(waterContainerEntity);

    notifyListeners();
  }

  Future<void> remove({
    required WaterContainerEntity waterContainerEntity,
    required BuildContext context,
  }) async {
    final removeContainerResult = await getResult(_waterContainerRepository.remove(waterContainerEntity));
    if (removeContainerResult is Failure) throw Exception();

    waterContainers.remove(waterContainerEntity);

    notifyListeners();

    SnackBarMessage.undo(
      context: context,
      text: 'Recipiente excluído',
      onPressed: () {
        add(waterContainerEntity);
      },
    );
  }

  Future<void> _handleRemoveWater({required BuildContext context, required int amount}) async {
    var result = await getResult(
      _waterRepository.removeDrankToday(amount),
    );

    if (result is! Failure) {
      SnackBarMessage.undo(
        context: context,
        text: '$amount ml removido',
        onPressed: () {
          _waterRepository.addDrankToday(amount);
        },
      );
    }
  }
}

/*
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../data/repositories/water_container_repository.dart';
import '../../data/repositories/water_repository.dart';
import '../../domain/entities/water_container_entity.dart';
import '../utils/dialogs.dart';
import '../utils/snackbar_message.dart';

class WaterContainerController extends ChangeNotifier {
  List<WaterContainerEntity> waterContainers = [];

  final WaterContainerRepository _waterContainerRepository;
  final WaterRepository _waterRepository;

  WaterContainerController(this._waterContainerRepository, this._waterRepository);

  Future<void> init() async {
    final waterContainers = await getResult(_waterContainerRepository.getAll());
    if (waterContainers is Failure) throw Exception();

    this.waterContainers = waterContainers;
    notifyListeners();
  }

  Future<void> add(WaterContainerEntity waterContainerEntity) async {
    final addContainerResult = await getResult(_waterContainerRepository.add(waterContainerEntity));
    if (addContainerResult is Failure) throw Exception();

    waterContainers.add(waterContainerEntity);

    notifyListeners();
  }

  Future<void> remove({
    required WaterContainerEntity waterContainerEntity,
    required BuildContext context,
  }) async {
    if (amount >= 3500) {
      await Dialogs.confirm(
        title: 'Remover quantidade?',
        text: 'Esta quantidade excede 3500ml',
        onYes: () async {
          _handleRemoveWater(amount: amount, context: context);
        },
        onNo: () => Navigator.pop(context),
        cancelText: 'Cancelar',
        confirmText: 'Sim, remover',
        context: context,
      );

      Navigator.pop(context);
      return;
    }
    
    _handleRemoveWater(amount: amount, context: context);

    Navigator.pop(context);

    final removeContainerResult = await getResult(_waterContainerRepository.remove(waterContainerEntity));
    if (removeContainerResult is Failure) throw Exception();

    waterContainers.remove(waterContainerEntity);

    notifyListeners();

    SnackBarMessage.undo(
      context: context,
      text: 'Recipiente excluído',
      onPressed: () {
        add(waterContainerEntity);
      },
    );
  }

  Future<void> _handleRemoveWater({required BuildContext context, required int amount}) async {
    var result = await getResult(
      _waterRepository.removeDrankToday(amount),
    );

    if (result is! Failure) {
      SnackBarMessage.undo(
        context: context,
        text: '$amount ml removido',
        onPressed: () {
          _waterRepository.addDrankToday(amount);
        },
      );
    }
  }
}

*/