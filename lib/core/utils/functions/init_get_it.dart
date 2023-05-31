import '../injection/registerers/register_get_it.dart';

void initGetIt(List<RegisterGetIt> registererFunctions) {
  for (var registererFunction in registererFunctions) {
    registererFunction();
  }
}
