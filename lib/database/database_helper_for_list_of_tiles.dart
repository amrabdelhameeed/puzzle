import 'package:puzzle_test_12_1_2022/data/models/tile_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBhelperForTiles {
  static final DBhelperForTiles instance = DBhelperForTiles._initialize();
  static Database? _databaseForTiles;
  DBhelperForTiles._initialize();
  Future _createDB(Database db, int version) async {
    await db.execute('''
        CREATE TABLE tiles(
          id INTEGER,
          color INTEGER
        )
        ''');
  }

  Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<Database> _initDB(String fileName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, fileName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onConfigure: _onConfigure,
    );
  }

  Future close() async {
    final db = await instance.database;
    db!.close();
  }

  Future<Database?> get database async {
    if (_databaseForTiles != null) {
      return _databaseForTiles;
    } else {
      _databaseForTiles = await _initDB('todoo.db');
      return _databaseForTiles;
    }
  }

  Future<TileModel> createtile(TileModel tiles) async {
    final db = await instance.database;
    await db!.insert('tiles', tiles.toJson());
    return tiles;
  }

  // Future<Score> getscore(int id) async {
  //   final db = await instance.database;
  //   final maps = await db!.query(
  //     'score',
  //     where: 'id = ?',
  //     whereArgs: [id],
  //   );

  //   if (maps.isNotEmpty) {
  //     return Score.fromJson(maps.first);
  //   } else {
  //     throw Exception('$id not found in the database.');
  //   }
  // }

  Future<List<TileModel>> getAlltiles() async {
    final db = await instance.database;
    final result = await db!.query(
      'tiles',
    );
    var list = result.map((e) => TileModel.fromJson(e)).toList();
    return list;
  }

  // Future<int> updateTileModel(TileModel tileModel) async {
  //   final db = await instance.database;
  //   return db!.update('tiles', tileModel.toJson(),
  //       where: '${tileModel.id} = ?',
  //       whereArgs: [tileModel.id],
  //       conflictAlgorithm: ConflictAlgorithm.replace);
  // }

  // Future<int> deletescore(int id) async {
  //   final db = await instance.database;
  //   return db!.delete(
  //     'score',
  //     where: 'id = ?',
  //     whereArgs: [id],
  //   );
  // }

  Future<void> deleteAllTileModels() async {
    final db = await instance.database;
    db!.delete(
      'tiles',
    );
  }
}
