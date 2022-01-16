import '../../constants/strings.dart';
import 'tile_model.dart';

class GeneratedTiles {
  List<TileModel> generatedTiles() {
    return List.generate(
        16,
        (index) => TileModel(
              id: index + 1,
              color: colors[index % 4],
            ));
  }
}
