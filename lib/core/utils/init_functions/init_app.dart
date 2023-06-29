import 'init_get_it.dart';
import 'init_hive.dart';

Future<void> initApp() async {
  initGetIt();
  await initHive();
}
