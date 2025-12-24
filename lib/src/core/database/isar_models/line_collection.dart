import 'package:isar_community/isar.dart';

part 'line_collection.g.dart';

@collection
class LineCollection {
  Id id = Isar.autoIncrement;

  late String linha;

  String? descricao;
}
