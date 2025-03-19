import 'package:flutter/material.dart';
import 'package:new_flutter_labs/Database%20Connectivity%20&%20Navigation/lab_15/my_database.dart';
import 'package:sqflite/sqflite.dart';

class ForDatabase extends StatefulWidget {
  const ForDatabase({super.key});

  @override
  State<ForDatabase> createState() => _ForDatabaseState();
}

class _ForDatabaseState extends State<ForDatabase> {
  MyDatabase database = MyDatabase();

  @override
  void initState() {
    super.initState();
    // deleteAll();
    selectAll();
  }

  Future<void> selectAll() async {
    await database.insertCategory("categoryName");

    // Retrieve the category_id using category_name
    Database db = await database.initDatabase();
    List<Map<String, dynamic>> categories = await db.rawQuery(
        "SELECT category_id FROM Categories WHERE category_name = ?", ["categoryName"]);

    if (categories.isNotEmpty) {
      int categoryId = categories.first["category_id"];

      // Insert task with the retrieved category_id
      await database.insertTask({
        "task_title": "hello",
        "task_description": "Buy vegetables and fruits for the week",
        "task_status": 0,
        "category_id": categoryId, // Assign the correct category_id
      });

      // Fetch and print tasks
      List<Map<String, dynamic>> tasks = await database.selectAllTasks();
      List<Map<String, dynamic>> taskJoin = await database.selectAllTasksUsingJoin();

      print("All Tasks: $tasks");
      print("Using INNER JOIN: $taskJoin");
    } else {
      print("Category not found.");
    }
  }
  Future<void> deleteAll()async{
    database.deleteTable();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
