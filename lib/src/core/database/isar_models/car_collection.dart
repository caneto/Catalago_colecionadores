import 'package:isar_community/isar.dart';

part 'car_collection.g.dart';

@collection
class CarCollection {
  Id id = Isar.autoIncrement;

  late String nomeMiniatura;
  late String marca;
  late String modelo;
  int? anoFabricacao;
  late String escala;
  DateTime? dataAquizicao;
  double? precoPago;
  String? notes;
  String? condition;
  String? collectionCondition;
  String? imagePath;
}
