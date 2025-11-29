import 'package:isar_community/isar.dart';

part 'marca_collection.g.dart';

@collection
class MarcaCollection {
  Id id = Isar.autoIncrement;

  late String nome;

  String? descricao;

  String? logo;

  int? quantidade;
}
