import 'package:flutter/foundation.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'isar_models/car_base_collection.dart';
import 'isar_models/car_base_collection_favorite.dart';
import 'isar_models/car_base_collection_gallery.dart';
import 'isar_models/car_collection.dart';
import 'isar_models/car_collection_gallery.dart';
import 'isar_models/category_collection.dart';
import 'isar_models/line_collection.dart'; // Added import
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
      final isar = await Isar.open(
        [
          CarBaseCollectionSchema,
          CarCollectionSchema,
          UserCollectionSchema,
          CategoryCollectionSchema,
          MarcaCollectionSchema,
          SerieCollectionSchema,
          LineCollectionSchema, // Added Schema
          CarBaseCollectionGallerySchema,
          CarCollectionGallerySchema,
          CarBaseCollectionFavoriteSchema,
        ],
        directory: dir.path,
        inspector: true,
        compactOnLaunch: CompactCondition(minFileSize: 10 * 1056 * 1056),
      );
      await _seedInitialData(isar);
      return isar;
    }
    return Future.value(Isar.getInstance());
  }

  Future<void> _seedInitialData(Isar isar) async {
    final categoryCount = await isar.categoryCollections.count();
    if (categoryCount == 0) {
      final initialCategories = [
        CategoryCollection()
          ..name = 'Carros'
          ..description = 'Carros de coleção',
        CategoryCollection()
          ..name = 'Carros Custom'
          ..description = 'Carros customizados',
        CategoryCollection()
          ..name = 'Carros de Corrida'
          ..description = 'Carros de corrida',
        CategoryCollection()
          ..name = 'Barcos'
          ..description = 'Barcos de coleção',
        CategoryCollection()
          ..name = 'Aviões'
          ..description = 'Aviões de coleção',
        CategoryCollection()
          ..name = 'Motos'
          ..description = 'Motos de coleção',
      ];

      await isar.writeTxn(() async {
        await isar.categoryCollections.putAll(initialCategories);
      });
      if (kDebugMode) {
        print('Seeded CategoryCollection with multiple validation data');
      }
    }

    final marcaCount = await isar.marcaCollections.count();
    if (marcaCount == 0) {
      final initialMarcas = [
        MarcaCollection()
          ..nome = 'Hot Wheels'
          ..quantidade = 0
          ..descricao = 'Hot Wheels é uma marca de miniaturas de carros',
        MarcaCollection()
          ..nome = 'Maisto'
          ..quantidade = 0
          ..descricao = 'Fabricante Maisto',
        MarcaCollection()
          ..nome = 'Matchbox'
          ..quantidade = 0
          ..descricao = 'Matchbox é uma marca de miniaturas de carros',
      ];

      await isar.writeTxn(() async {
        await isar.marcaCollections.putAll(initialMarcas);
      });
      if (kDebugMode) {
        print('Seeded MarcaCollection with multiple validation data');
      }
    }

    final serieCount = await isar.serieCollections.count();
    if (serieCount == 0) {
      final initialSeries = [
        SerieCollection()
          ..nome = 'Mainline'
          ..numero = '1'
          ..marca = 'Hot Wheels'
          ..descricao = 'Série principal',
        SerieCollection()
          ..nome = 'Elite 64'
          ..numero = '2'
          ..marca = 'Hot Wheels'
          ..descricao = 'Série elite 64',
        SerieCollection()
          ..nome = '5-Pack'
          ..numero = '3'
          ..marca = 'Hot Wheels'
          ..descricao = 'Série 5-Pack',
        SerieCollection()
          ..nome = 'Mystery Models'
          ..numero = '4'
          ..marca = 'Hot Wheels'
          ..descricao = 'Série mystery models',  
        SerieCollection()
          ..nome = 'Formula 1'
          ..numero = '5'
          ..marca = 'Hot Wheels'
          ..descricao = 'Série formula 1',  
        SerieCollection()
          ..nome = 'RLC'
          ..numero = '6'
          ..marca = 'Hot Wheels'
          ..descricao = 'Série RLC',  
        SerieCollection()
          ..nome = 'Fast & Furious'
          ..numero = '7'
          ..marca = 'Hot Wheels'
          ..descricao = 'Série Fast & Furious',    
        SerieCollection()
          ..nome = 'Batman'
          ..numero = '8'
          ..marca = 'Hot Wheels'
          ..descricao = 'Série Batman',            
        SerieCollection()
          ..nome = 'Themed Mult-Packs'
          ..numero = '9'
          ..marca = 'Hot Wheels'
          ..descricao = 'Série Themed Mult-Packs',
        SerieCollection()
          ..nome = 'Vintage Racing Club'
          ..numero = '10'
          ..marca = 'Hot Wheels'
          ..descricao = 'Série Vintage Racing Club',        
        SerieCollection()
          ..nome = 'Car Culture'
          ..numero = '11'
          ..marca = 'Hot Wheels'
          ..descricao = 'Série Car Culture',      
        SerieCollection()
          ..nome = 'Themed Automotive'
          ..numero = '12'
          ..marca = 'Hot Wheels'
          ..descricao = 'Série Themed Automotive',       
      ];

      await isar.writeTxn(() async {
        await isar.serieCollections.putAll(initialSeries);
      });
      if (kDebugMode) {
        print('Seeded SerieCollection with multiple validation data');
      }
    }

    final lineCount = await isar.lineCollections.count();
    if (lineCount == 0) {
      final initialLines = [
        LineCollection()
          ..linha = '2024'
          ..descricao = 'Linha de 2024',
        LineCollection()
          ..linha = '2025'
          ..descricao = 'Linha de 2025',
      ];

      await isar.writeTxn(() async {
        await isar.lineCollections.putAll(initialLines);
      });
      if (kDebugMode) {
        print('Seeded LineCollection with multiple validation data');
      }
    }
  }

  Future<void> saveCar(CarCollection car, {List<String>? imagesBase64}) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.carCollections.put(car);
      if (imagesBase64 != null && imagesBase64.isNotEmpty) {
        for (var base64 in imagesBase64) {
          final galleryItem = CarCollectionGallery()..imageBase64 = base64;
          galleryItem.car.value = car;
          await isar.carCollectionGallerys.put(galleryItem);
          await galleryItem.car.save();
        }
      }
    });
  }

  Future<void> deleteCar(Id id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      final car = await isar.carCollections.get(id);
      if (car != null) {
        // Load gallery items to be sure
        await car.gallery.load();
        // Delete all gallery items associated with this car
        for (var item in car.gallery) {
          await isar.carCollectionGallerys.delete(item.id);
        }
        await isar.carCollections.delete(id);
      }
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
        .usernameContains(query, caseSensitive: false)
        .or()
        .fullnameContains(query, caseSensitive: false)
        .or()
        .emailContains(query, caseSensitive: false)
        .findAll();
  }

  Future<UserCollection?> loginUser(String username, String password) async {
    final isar = await db;
    final user = await isar.userCollections
        .filter()
        .usernameEqualTo(username, caseSensitive: false)
        .findFirst();

    if (user != null && user.password == password) {
      return user;
    }
    return null;
  }

  Future<UserCollection?> getUserByEmailOrUsername(String identifier) async {
    final isar = await db;
    return await isar.userCollections
        .filter()
        .emailEqualTo(identifier, caseSensitive: false)
        .or()
        .usernameEqualTo(identifier, caseSensitive: false)
        .findFirst();
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

  Future<void> saveCarBase(
    CarBaseCollection car, {
    List<String>? imagesBase64,
  }) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.carBaseCollections.put(car);
      if (imagesBase64 != null && imagesBase64.isNotEmpty) {
        for (var base64 in imagesBase64) {
          final galleryItem = CarBaseCollectionGallery()..imageBase64 = base64;
          galleryItem.carBase.value = car;
          await isar.carBaseCollectionGallerys.put(galleryItem);
          await galleryItem.carBase.save();
        }
      }
    });
  }

  Future<List<CarBaseCollection>> getAllCarsBase() async {
    final isar = await db;
    return await isar.carBaseCollections.where().findAll();
  }

  Future<void> deleteCarBase(Id id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      final car = await isar.carBaseCollections.get(id);
      if (car != null) {
        await car.gallery.load();
        for (var item in car.gallery) {
          await isar.carBaseCollectionGallerys.delete(item.id);
        }
        await isar.carBaseCollections.delete(id);
      }
    });
  }

  Future<void> toggleFavorite(int carBaseId) async {
    final isar = await db;
    await isar.writeTxn(() async {
      final existing = await isar.carBaseCollectionFavorites
          .filter()
          .carBaseIdEqualTo(carBaseId)
          .findFirst();

      if (existing != null) {
        // Toggle: if it exists, remove it (or set to false, but removing is cleaner for "isFavorite")
        await isar.carBaseCollectionFavorites.delete(existing.id);
      } else {
        final newFavorite = CarBaseCollectionFavorite()
          ..carBaseId = carBaseId
          ..isFavorite = true;
        await isar.carBaseCollectionFavorites.put(newFavorite);
      }
    });
  }

  Future<List<int>> getAllFavoriteIds() async {
    final isar = await db;
    final favorites = await isar.carBaseCollectionFavorites.where().findAll();
    return favorites.map((e) => e.carBaseId).toList();
  }

  Future<bool> isFavorite(int carBaseId) async {
    final isar = await db;
    final count = await isar.carBaseCollectionFavorites
        .filter()
        .carBaseIdEqualTo(carBaseId)
        .count();
    return count > 0;
  }

  Future<List<CarBaseCollection?>> getFavoriteBaseCars() async {
    final isar = await db;
    final favoriteIds = await getAllFavoriteIds();
    // Fetch all cars corresponding to the favorite IDs.
    // getAll returns a list of nullable objects (List<CarBaseCollection?>)
    // because some IDs might not exist anymore (though unlikely with proper constraints).
    final cars = await isar.carBaseCollections.getAll(favoriteIds);
    for (var car in cars) {
      if (car != null) {
        await car.gallery.load();
      }
    }
    return cars;
  }

  Future<List<CarBaseCollection>> searchFavoriteBaseCars(String query) async {
    final isar = await db;
    final favoriteIds = await getAllFavoriteIds();

    if (favoriteIds.isEmpty) {
      return [];
    }

    final cars = await isar.carBaseCollections
        .filter()
        .anyOf(favoriteIds, (q, id) => q.idEqualTo(id))
        .and()
        .group(
          (q) => q
              .nomeMiniaturaContains(query, caseSensitive: false)
              .or()
              .marcaContains(query, caseSensitive: false)
              .or()
              .modeloContains(query, caseSensitive: false),
        )
        .findAll();

    for (var car in cars) {
      await car.gallery.load();
    }

    return cars;
  }

  // --- Line Collection Methods ---

  Future<void> saveLine(LineCollection line) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.lineCollections.putSync(line));
  }

  Future<List<LineCollection>> getAllLines() async {
    final isar = await db;
    return await isar.lineCollections.where().findAll();
  }

  Future<void> deleteLine(Id id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.lineCollections.delete(id);
    });
  }
}
