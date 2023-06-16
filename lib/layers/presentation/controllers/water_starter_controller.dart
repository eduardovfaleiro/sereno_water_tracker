import 'package:flutter/material.dart';

import '../pages/water_starter_page/water_starter_model.dart';

class WaterStarterController extends ChangeNotifier {
  final WaterStarterModel _waterStarterModel;

  WaterStarterController(this._waterStarterModel);

  double get weight => _waterStarterModel.weight;

  void updateWeight(double weight) {
    _waterStarterModel.weight = weight;

    notifyListeners();
  }
}
