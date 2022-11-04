import 'package:green_mode/podcast/data/downloads/download_database_service.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider instance = DatabaseProvider._init();

  DatabaseProvider._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB("download.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onConfigure: _onConfigure,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    //Game
    await db.execute(DownloadDatabaseService.createTableQuery);

  
  }

  Future<void> _onConfigure(Database db) async {
    // Add support for foriegn keys
    await db.execute("PRAGMA foreign_keys = ON");
  }

  Future closeDB() async {
    final db = await instance.database;

    db.close();
  }
}