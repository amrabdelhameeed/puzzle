import 'package:puzzle_test_12_1_2022/data/models/score_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBhelper {
  static final DBhelper instance = DBhelper._initialize();
  static Database? _database;
  DBhelper._initialize();
  Future _createDB(Database db, int version) async {
    await db.execute('''
        CREATE TABLE score(
          moves INTEGER,
          seconds INTEGER,
          dateTime TEXT NOT NULL
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
    if (_database != null) {
      return _database;
    } else {
      _database = await _initDB('todo.db');
      return _database;
    }
  }

  Future<Score> createscore(Score score) async {
    final db = await instance.database;
    await db!.insert('score', score.toJson());
    return score;
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

  Future<List<Score>> getAllscores() async {
    final db = await instance.database;
    final result = await db!.query(
      'score',
    );
    var list = result.map((e) => Score.fromJson(e)).toList();
    list.sort(
        (a, b) => (a.seconds! + a.moves!).compareTo((b.seconds! + b.seconds!)));
    return list;
  }

  // Future<int> updatescore(Score score) async {
  //   final db = await instance.database;
  //   return db!.update('score', score.toJson(),
  //       where: '${score.id} = ?',
  //       whereArgs: [score.id],
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

  Future<int> deleteAllscores() async {
    final db = await instance.database;
    return db!.delete(
      'score',
    );
  }
}
