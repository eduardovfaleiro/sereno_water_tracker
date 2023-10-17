// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_flutter/hive_flutter.dart';

part 'drink_record_entity.g.dart';

@HiveType(typeId: 2)
class DrinkRecordEntity {
  @HiveField(0)
  final int amount;

  @HiveField(1)
  final DateTime dateTime;

  DrinkRecordEntity(this.amount, this.dateTime);

  @override
  bool operator ==(covariant DrinkRecordEntity other) {
    if (identical(this, other)) return true;

    return other.amount == amount && other.dateTime == dateTime;
  }

  @override
  int get hashCode => amount.hashCode ^ dateTime.hashCode;
}
