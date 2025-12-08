import 'package:isar_community/isar.dart';

part 'car_base_collection.g.dart';

@collection
class CarBaseCollection {
  Id id = Isar.autoIncrement;

  late String nomeMiniatura;
  late String categoria;
  late String marca;
  late String modelo;
  int? anoFabricacao;
  late String escala;
  String? notes;

  String? imagePath;
  List<String>? images;
}
