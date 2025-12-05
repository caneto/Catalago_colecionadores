import 'package:isar_community/isar.dart';

part 'category_collection.g.dart';

@collection
class CategoryCollection {
  Id id = Isar.autoIncrement;

  late String name;

  String? description;

  String? imagePath;

  List<String>? images;
}
