import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../user model/constants.dart';
import '../user model/user.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();


  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('matrimony.db'); // Common database file name.
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'INTEGER NOT NULL';

    // Create the users table.
    await db.execute('''
          CREATE TABLE users (
            $ID INTEGER PRIMARY KEY AUTOINCREMENT,
            $NAME TEXT,
            $EMAIL TEXT UNIQUE,
            $PHONE TEXT,
            $CITY TEXT,
            $DOB TEXT,
            $GENDER TEXT,
            $HOBBIES TEXT,
            $OTH_HOBBIES TEXT,
            $EDUCATION TEXT,
            $OCCUPATION TEXT,
            $WORK_PLACE TEXT,
            $INCOME TEXT,
            $PASSWORD TEXT,
            $CON_PASS TEXT,
            $AGE INTEGER,
            $ISLIKED INTEGER
          )
        ''');
  }

  /// Inserts a new row into the [User.tableName] table.
  Future<int> createUser(Map<String, dynamic> row) async {
    final db = await instance.database;

    if (row.containsKey('isLiked')) {
      row['isLiked'] = (row['isLiked'] == true) ? 1 : 0;
    }

    return await db.insert(User.tableName, row);
  }


  Future<Map<String, dynamic>?> getUser(int id) async {
    final db = await instance.database;
    final result = await db.query(
      User.tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await instance.database;
    return await db.query(User.tableName);
  }

  Future<int> updateUser(Map<String, dynamic> user) async {
    final db = await instance.database;

    // if (!user.containsKey(ID) || user[ID] == null) {
    //   throw Exception("User ID is missing for update.");
    // }

    return await db.update(
      'users',
      user,
      where: '$ID = ?', // Use string interpolation here
      whereArgs: [user[ID]],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await instance.database;
    return await db.delete(
      User.tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<void> updateLikeStatus(int userId, int isLiked) async {
    final db = await database;
    await db.update(
      'users',
      {ISLIKED: isLiked},
      where: 'ID = ?',
      whereArgs: [userId],
    );
  }

  Future<List<Map<String, dynamic>>> getFavoriteUsers() async {
    final db = await database;
    return await db.query(
      'users',
      where: '$ISLIKED = ?',
      whereArgs: [1], // Fetch only liked users
    );
  }

}