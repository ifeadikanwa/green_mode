import 'package:green_mode/podcast/data/downloads/database_constants.dart';
import 'package:green_mode/podcast/data/downloads/database_provider.dart';
import 'package:green_mode/podcast/data/downloads/download.dart';
import 'package:sqflite/sqflite.dart';

class DownloadDatabaseService {
  static final DatabaseProvider _databaseProvider = DatabaseProvider.instance;

  static const downloadTable = "download";

  static const createTableQuery = '''
    CREATE TABLE $downloadTable(
      id $idType,
      title $textType,
      podcastName $nullableTextType,
      episodeDescription $textType,
      podcastUrl $nullableTextType,
      imageUrl $nullableTextType,
      audioUrl $nullableTextType,
      duration $nullableIntegerType,
      downloaded $boolType,
      filePath $textType
    )
  ''';

  static Future<Download> createDownload(Download download) async {
    final db = await _databaseProvider.database;
    final id = await db.insert(
      downloadTable,
      download.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return download.copyWith(id: id);
  }

  static Future<void> deleteDownload(int downloadID) async {
    final db = await _databaseProvider.database;
    await db.delete(
      downloadTable,
      where: "id = ?",
      whereArgs: [downloadID],
    );
  }

  static Future<Download?> getDownload(int downloadID) async {
    final db = await _databaseProvider.database;
    final downloadsMaps = await db.query(
      downloadTable,
      columns: Download.allColumns,
      where: "id = ?",
      whereArgs: [downloadID],
    );

    if (downloadsMaps.isNotEmpty) {
      return Download.fromMap(downloadMap: downloadsMaps.first);
    } else {
      return null;
    }
  }

  static Future<List<Download>> getAllDownloads() async {
    final db = await _databaseProvider.database;
    final downloadsMaps = await db.query(
      downloadTable,
      columns: Download.allColumns,
    );

    return downloadsMaps
        .map((downloadMap) => Download.fromMap(downloadMap: downloadMap))
        .toList();
  }

  static Future<void> updateDownload(Download download) async {
    final db = await _databaseProvider.database;
    await db.update(
      downloadTable,
      download.toMap(),
      where: "id = ?",
      whereArgs: [download.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
