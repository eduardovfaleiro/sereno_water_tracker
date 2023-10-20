import '../../../core/core.dart';
import '../../data/repositories/water_repository.dart';
import '../entities/water_container_entity.dart';

abstract class WaterContainerGeneratorService {
  Future<List<WaterContainerEntity>> generate();
}

class WaterContainerGeneratorServiceImp implements WaterContainerGeneratorService {
  final WaterRepository _waterRepository;

  WaterContainerGeneratorServiceImp(this._waterRepository);

  @override
  Future<List<WaterContainerEntity>> generate() async {
    int amountPerDrink = await getResult(_waterRepository.getAmountPerDrink());

    String assetName = () {
      if (amountPerDrink <= 100) return 'cup_of_tea.svg';
      if (amountPerDrink <= 200) return 'cup.svg';
      if (amountPerDrink <= 2000) return 'bottle.svg';

      return 'gallon.svg';
    }();

    var defaultContainer = WaterContainerEntity(assetName: assetName, amount: amountPerDrink);

    return <WaterContainerEntity>[
      defaultContainer,
      const WaterContainerEntity(amount: 200, assetName: 'cup.svg'),
      const WaterContainerEntity(amount: 500, assetName: 'bottle.svg'),
      const WaterContainerEntity(amount: 100, assetName: 'cup_of_tea.svg'),
      const WaterContainerEntity(amount: 20000, assetName: 'gallon.svg'),
    ];
  }
}
