import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'isar_models/car_collection.dart';
import 'isar_models/category_collection.dart';
import 'isar_models/marca_collection.dart';
import 'isar_models/serie_collection.dart';
import 'isar_models/user_collection.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [
          CarCollectionSchema,
          UserCollectionSchema,
          CategoryCollectionSchema,
          MarcaCollectionSchema,
          SerieCollectionSchema,
        ],
        directory: dir.path,
        inspector: true,
        compactOnLaunch: CompactCondition(minFileSize: 10 * 1056 * 1056),
      );
    }
    return Future.value(Isar.getInstance());
  }

  Future<void> saveCar(CarCollection car) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.carCollections.putSync(car));
  }

  Future<void> deleteCar(Id id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.carCollections.delete(id);
    });
  }

  Future<List<CarCollection>> getAllCars() async {
    final isar = await db;
    return await isar.carCollections.where().findAll();
  }

  Future<List<CarCollection>> searchCars(String query) async {
    final isar = await db;
    return await isar.carCollections
        .filter()
        .nomeMiniaturaContains(query, caseSensitive: false)
        .or()
        .marcaContains(query, caseSensitive: false)
        .or()
        .modeloContains(query, caseSensitive: false)
        .findAll();
  }

  Future<CarCollection?> getCarById(Id id) async {
    final isar = await db;
    return await isar.carCollections.get(id);
  }

  Future<List<CarCollection>> getCarsByExactName(String name) async {
    final isar = await db;
    return await isar.carCollections
        .filter()
        .nomeMiniaturaEqualTo(name)
        .findAll();
  }

  Future<void> saveUser(UserCollection user) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.userCollections.putSync(user));
  }

  Future<void> deleteUser(Id id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.userCollections.delete(id);
    });
  }

  Future<List<UserCollection>> searchUsers(String query) async {
    final isar = await db;
    return await isar.userCollections
        .filter()
        .nameContains(query, caseSensitive: false)
        .or()
        .emailContains(query, caseSensitive: false)
        .findAll();
  }

  Future<UserCollection?> loginUser(String email, String password) async {
    final isar = await db;
    final user = await isar.userCollections
        .filter()
        .emailEqualTo(email, caseSensitive: false)
        .findFirst();

    if (user != null && user.password == password) {
      return user;
    }
    return null;
  }

  Future<void> saveCategory(CategoryCollection category) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.categoryCollections.putSync(category));
  }

  Future<List<CategoryCollection>> getAllCategories() async {
    final isar = await db;
    return await isar.categoryCollections.where().findAll();
  }

  Future<void> deleteCategory(Id id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.categoryCollections.delete(id);
    });
  }

  Future<void> saveMarca(MarcaCollection marca) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.marcaCollections.putSync(marca));
  }

  Future<List<MarcaCollection>> getAllMarcas() async {
    final isar = await db;
    return await isar.marcaCollections.where().findAll();
  }

  Future<void> deleteMarca(Id id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.marcaCollections.delete(id);
    });
  }

  Future<void> saveSerie(SerieCollection serie) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.serieCollections.putSync(serie));
  }

  Future<List<SerieCollection>> getAllSeries() async {
    final isar = await db;
    return await isar.serieCollections.where().findAll();
  }

  Future<void> deleteSerie(Id id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.serieCollections.delete(id);
    });
  }
}
