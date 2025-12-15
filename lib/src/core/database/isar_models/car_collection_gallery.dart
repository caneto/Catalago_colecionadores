import 'package:isar_community/isar.dart';

import 'car_collection.dart';

part 'car_collection_gallery.g.dart';

@collection
class CarCollectionGallery {
  Id id = Isar.autoIncrement;

  late String imageBase64;

  final car = IsarLink<CarCollection>();
}
