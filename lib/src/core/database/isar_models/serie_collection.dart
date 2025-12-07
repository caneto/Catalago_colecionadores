import 'package:isar_community/isar.dart';

part 'serie_collection.g.dart';

@collection
class SerieCollection {
  Id id = Isar.autoIncrement;

  late String nome;

  late String numero;

  late String marca;

  String? descricao;
}
