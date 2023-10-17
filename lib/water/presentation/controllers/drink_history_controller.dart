


// class DrinkHistoryController {
//   final ValueNotifier<List<DrinkRecordEntity>> _records;

//   ValueNotifier<List<DrinkRecordEntity>> get records => _records.

//   void initialize() {
//     getIt<HiveInterface>().box(DRINK_HISTORY).listenable().addListener(() {
//       _records.value = List.from(getIt<HiveInterface>().box(DRINK_HISTORY).values);
//     });
//   }

//   Future<void> remove() async {

//   }
// }
