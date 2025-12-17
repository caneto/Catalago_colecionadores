import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:catalago_colecionadores/src/core/database/isar_models/car_base_collection.dart';
import 'package:catalago_colecionadores/src/core/database/isar_models/car_base_collection_gallery.dart';
import 'package:catalago_colecionadores/src/core/database/isar_models/car_collection.dart';
import 'package:catalago_colecionadores/src/core/database/isar_models/car_collection_gallery.dart';
import 'package:catalago_colecionadores/src/core/database/isar_models/category_collection.dart';
import 'package:catalago_colecionadores/src/core/database/isar_models/marca_collection.dart';
import 'package:catalago_colecionadores/src/core/database/isar_models/serie_collection.dart';
import 'package:catalago_colecionadores/src/core/database/isar_models/user_collection.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

abstract class BackupStrategy {
  Future<File> execute(Isar isar);
}

class FullZipBackupStrategy implements BackupStrategy {
  @override
  Future<File> execute(Isar isar) async {
    final dbName = isar.name;
    final dbDir = Directory(
      isar.directory ?? (await getApplicationDocumentsDirectory()).path,
    );

    // Create a temporary directory for the backup
    final tempDir = await getTemporaryDirectory();
    final backupDir = Directory(
      '${tempDir.path}/isar_backup_${DateTime.now().millisecondsSinceEpoch}',
    );
    await backupDir.create();

    // Copy Isar files (default.isar and default.isar.lock usually)
    // We try to copy the main file. Isar usually has 'name.isar'.
    // If strict match is needed we list files.
    final files = dbDir.listSync();
    for (var file in files) {
      if (file is File &&
          (file.path.endsWith('$dbName.isar') ||
              file.path.endsWith('$dbName.isar.lock'))) {
        await file.copy('${backupDir.path}/${file.uri.pathSegments.last}');
      }
    }

    // Zip the directory
    final encoder = ZipFileEncoder();
    final zipFile = File(
      '${tempDir.path}/backup_completo_${DateTime.now().millisecondsSinceEpoch}.zip',
    );
    encoder.create(zipFile.path);
    encoder.addDirectory(backupDir);
    encoder.close();

    // Move to download directory
    final downloadDir = await _getDownloadDirectory();
    final targetFile = File(
      '${downloadDir.path}/${zipFile.uri.pathSegments.last}',
    );
    await zipFile.copy(targetFile.path);

    // Cleanup
    await backupDir.delete(recursive: true);
    await zipFile.delete();

    return targetFile;
  }
}

class JsonZipBackupStrategy implements BackupStrategy {
  @override
  Future<File> execute(Isar isar) async {
    final tempDir = await getTemporaryDirectory();
    final jsonDir = Directory(
      '${tempDir.path}/json_backup_${DateTime.now().millisecondsSinceEpoch}',
    );
    await jsonDir.create();

    // Export collections to JSON
    await _exportCollection(isar.carCollections, 'car_collection', jsonDir);
    await _exportCollection(
      isar.carBaseCollections,
      'car_base_collection',
      jsonDir,
    );
    await _exportCollection(isar.userCollections, 'user_collection', jsonDir);
    await _exportCollection(
      isar.categoryCollections,
      'category_collection',
      jsonDir,
    );
    await _exportCollection(isar.marcaCollections, 'marca_collection', jsonDir);
    await _exportCollection(isar.serieCollections, 'serie_collection', jsonDir);
    await _exportCollection(
      isar.carCollectionGallerys,
      'car_collection_gallery',
      jsonDir,
    );
    await _exportCollection(
      isar.carBaseCollectionGallerys,
      'car_base_collection_gallery',
      jsonDir,
    );

    // Zip the directory
    final encoder = ZipFileEncoder();
    final zipFile = File(
      '${tempDir.path}/backup_json_${DateTime.now().millisecondsSinceEpoch}.zip',
    );
    encoder.create(zipFile.path);
    encoder.addDirectory(jsonDir);
    encoder.close();

    // Move to download directory
    final downloadDir = await _getDownloadDirectory();
    final targetFile = File(
      '${downloadDir.path}/${zipFile.uri.pathSegments.last}',
    );
    await zipFile.copy(targetFile.path);

    // Cleanup
    await jsonDir.delete(recursive: true);
    await zipFile.delete();

    return targetFile;
  }

  Future<void> _exportCollection<T>(
    IsarCollection<T> collection,
    String name,
    Directory dir,
  ) async {
    final data = await collection.where().exportJson();
    final file = File('${dir.path}/$name.json');
    await file.writeAsString(jsonEncode(data));
  }
}

Future<Directory> _getDownloadDirectory() async {
  if (Platform.isAndroid) {
    return Directory('/storage/emulated/0/Download');
  }
  final dir = await getDownloadsDirectory();
  if (dir != null) {
    return dir;
  }
  return await getApplicationDocumentsDirectory();
}

class BackupService {
  Future<String> performBackup(Isar isar, BackupStrategy strategy) async {
    try {
      final file = await strategy.execute(isar);
      return "Backup salvo em: ${file.path}";
    } catch (e) {
      return "Erro ao realizar backup: $e";
    }
  }
}
