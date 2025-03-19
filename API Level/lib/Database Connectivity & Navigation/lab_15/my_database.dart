import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDatabase {
  Future<Database> initDatabase() async {
    Directory directory = await getApplicationCacheDirectory();
    String path = join(directory.path, 'todoList.db');

    var db =
    await openDatabase(path, version: 6, onCreate: (db, version) async {
      await _createTables(db);
    }, onUpgrade: (db, oldVersion, newVersion) {});

    return db;
  }

  Future<void> _createTables(Database db) async {
    await db.execute('''
      CREATE TABLE Categories (
        category_id INTEGER PRIMARY KEY AUTOINCREMENT,
        category_name TEXT NOT NULL
      )
    ''');
    await db.execute('INSERT INTO Categories (category_name) VALUES("Work"), ("Personal"),("Shopping"), ("Study")');

    await db.execute('''
      CREATE TABLE Tasks (
        task_id INTEGER PRIMARY KEY AUTOINCREMENT,
        task_title TEXT NOT NULL,
        task_description TEXT,
        task_status INTEGER NOT NULL DEFAULT 0,
        category_id INTEGER,
        FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE CASCADE
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> selectAllTasks() async {
    Database db = await initDatabase();
    return await db.rawQuery("SELECT * FROM Tasks");
  }

  Future<List<Map<String, dynamic>>> selectAllTasksUsingJoin() async {
    Database db = await initDatabase();
    return await db.rawQuery(
        "SELECT * FROM Tasks JOIN Categories ON Tasks.category_id = Categories.category_id");
  }

  Future<void> insertTask(Map<String, dynamic> taskDetail) async {
    Database db = await initDatabase();
    await db.insert("Tasks", taskDetail);
  }

  Future<void> insertCategory(String categoryName) async {
    Database db = await initDatabase();
    await db.insert("Categories", {"category_name": categoryName});
  }

  Future<void> deleteTable() async {
    Database db = await initDatabase();
    await db.delete("Categories");
    await db.delete("tasks");
  }

  Future<void> deleteTask(int taskID) async {
    Database db = await initDatabase();
    await db.rawDelete('DELETE FROM tasks WHERE task_id = ?', [taskID]);
  }


  Future<void> editTask(Map<String, dynamic> updatedDetail, int taskID) async {
    Database db = await initDatabase();
    await db.rawQuery(
        'update tasks set task_title=?,task_description=? where task_id=?', [
      updatedDetail['task_title'],
      updatedDetail['task_description'],
      taskID
    ]);
  }

  updateTaskStatus(int taskID,int status) async {
    Database db = await initDatabase();
    int newStatus;
    if(status==0){
      newStatus=1;
    }
    else{
      newStatus=0;
    }
    await db.rawQuery('update tasks set task_status=? where task_id=?',[newStatus,taskID]);
  }
}
