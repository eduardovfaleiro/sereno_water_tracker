// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class WaterContainerEntity {
  final IconData icon;
  final int amount;

  const WaterContainerEntity({
    required this.icon,
    required this.amount,
  });

  @override
  bool operator ==(covariant WaterContainerEntity other) {
    if (identical(this, other)) return true;

    return other.icon == icon && other.amount == amount;
  }

  @override
  int get hashCode => icon.hashCode ^ amount.hashCode;
}
