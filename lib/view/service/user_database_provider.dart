// ignore_for_file: prefer_final_fields, unnecessary_null_comparison
import 'package:path/path.dart';
import 'package:fluttersqflite/core/init/database/database_provider.dart';
import 'package:fluttersqflite/view/model/user_model.dart';
import 'package:sqflite/sqflite.dart';

class UserDatabaseProvider extends DatabaseProvider<UserModel> {
  static final UserDatabaseProvider instance = UserDatabaseProvider._init();

  static Database? _database;

  UserDatabaseProvider._init();

  String _userDatabaseName = "userDatabase.db";
  String _userTableName = "user";
  int _version = 1;
  String _columnId = "id";
  String _columnName = "name";
  String _columnSurname = "surname";
  String _columnAge = "age";
  String _columnEmail = "email";

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(_userDatabaseName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    final response =
        await openDatabase(path, version: _version, onCreate: _createDB);
    return response;
  }

  Future _createDB(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE $_userTableName (
        $_columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
        $_columnName VARCHAR(20),
        $_columnSurname VARCHAR(20),
        $_columnAge INTEGER,
        $_columnEmail VARCHAR(20)
        )
        ''',
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  @override
  Future<bool?> add(UserModel model) async {
    final db = await instance.database;
    final userMaps = await db.insert(
      _userTableName,
      model.toJson(),
    );

    return userMaps != null;
  }

  @override
  Future<bool?> delete(int id) async {
    final db = await instance.database;
    final userMaps = await db.delete(
      _userTableName,
      where: '$_columnId = ?',
      whereArgs: [id],
    );

    return userMaps != null;
  }

  @override
  Future<UserModel?> get(int id) async {
    final db = await instance.database;
    final userMaps = await db.query(
      _userTableName,
      where: '$_columnId = ?',
      columns: [_columnId],
      whereArgs: [id],
    );

    if (userMaps.isNotEmpty) {
      return UserModel.fromJson(userMaps.first);
    }
    return null;
  }

  @override
  Future<List<UserModel>?> getAll() async {
    final db = await instance.database;

    List<Map<String, dynamic>> userMaps = await db.query(_userTableName);
    if (userMaps.isNotEmpty) {
      return userMaps.map((e) => UserModel.fromJson(e)).toList();
    }
    return null;
  }

  @override
  Future<bool?> update(int id, UserModel model) async {
    final db = await instance.database;

    final userMaps = await db.update(
      _userTableName,
      model.toJson(),
      where: '$_columnId = ?',
      whereArgs: [id],
    );

    return userMaps != null;
  }
}
