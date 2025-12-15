import 'package:isar_community/isar.dart';

import 'car_base_collection.dart';

part 'car_base_collection_gallery.g.dart';

@collection
class CarBaseCollectionGallery {
  Id id = Isar.autoIncrement;

  late String imageBase64;

  final carBase = IsarLink<CarBaseCollection>();
}
