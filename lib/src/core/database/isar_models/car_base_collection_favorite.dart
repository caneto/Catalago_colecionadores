import 'package:isar_community/isar.dart';

part 'car_base_collection_favorite.g.dart';

@collection
class CarBaseCollectionFavorite {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late int carBaseId;

  bool isFavorite = true;
}
