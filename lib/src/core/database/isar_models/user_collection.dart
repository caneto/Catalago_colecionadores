import 'package:isar_community/isar.dart';

part 'user_collection.g.dart';

@collection
class UserCollection {
  Id id = Isar.autoIncrement;

  late String username;

  late String fullname;

  @Index(unique: true, replace: true)
  late String email;

  late String password;
}
