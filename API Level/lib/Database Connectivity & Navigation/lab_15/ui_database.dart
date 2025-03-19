import 'package:flutter/material.dart';
import 'package:new_flutter_labs/Database%20Connectivity%20&%20Navigation/lab_15/my_database.dart';
import 'package:sqflite/sqflite.dart';

class UiDatabase extends StatefulWidget {
  const UiDatabase({super.key});

  @override
  State<UiDatabase> createState() => _UiDatabaseState();
}

MyDatabase database = MyDatabase();

void selectState() async {
  List<Map<String, dynamic>> list = await database.selectAllTasks();
  print(list);
}

GlobalKey<FormState> _key = GlobalKey();

class _UiDatabaseState extends State<UiDatabase> {
  TextEditingController taskTitle = TextEditingController();
  TextEditingController taskDescription = TextEditingController();
  TextEditingController taskCategory = TextEditingController();
  List<String> predefinedCategories = [
    "Work",
    "Personal",
    "Shopping",
    "Study",
    "Other"
  ];

  List<String> category = ["Work", "Personal", "Shopping", "Study", "Other"];
  String selectedCategory = "Work";
  bool isOtherSelected = false;
  MyDatabase database = MyDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To-Do List',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
        ),
        backgroundColor: Colors.cyan,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () {
          taskTitle.clear();
          taskDescription.clear();
          taskCategory.clear();
          setState(() {
            selectedCategory = 'Work';
            isOtherSelected = false;
          });
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                title: Text(
                  'Add Task',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.cyan,
                  ),
                ),
                content: SingleChildScrollView(
                  // Allow scrolling if the content exceeds height
                  child: Form(
                    key: _key,
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Ensure minimal height
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getTextFormField('Task Title', taskTitle),
                        getTextFormField('Task Description', taskDescription),
                        getDropdownOfCategory(predefinedCategories),
                      ],
                    ),
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () async {
                      if (_key.currentState?.validate() ?? false) {
                        Database db = await database.initDatabase();
                        int categoryId;

                        if (selectedCategory == 'Other') {
                          List<
                              Map<String,
                                  dynamic>> categories = await db.rawQuery(
                              "SELECT category_id FROM Categories WHERE category_name = ?",
                              [taskCategory.text]);

                          if (categories.isEmpty) {
                            await database.insertCategory(taskCategory.text);
                            categories = await db.rawQuery(
                              "SELECT category_id FROM Categories WHERE category_name = ?",
                              [taskCategory.text],
                            );
                          }

                          if (categories.isNotEmpty) {
                            categoryId = categories.first["category_id"];
                          } else {
                            print("Error: Category insertion failed.");
                            return;
                          }
                        } else {
                          List<
                              Map<String,
                                  dynamic>> categories = await db.rawQuery(
                              "SELECT category_id FROM Categories WHERE category_name = ?",
                              [selectedCategory]);
                          if (categories.isNotEmpty) {
                            categoryId = categories.first["category_id"];
                          } else {
                            return;
                          }
                        }

                        Map<String, dynamic> taskData = {
                          "task_title": taskTitle.text,
                          "task_description": taskDescription.text,
                          "category_id": categoryId,
                        };

                        await database.insertTask(taskData);
                        Navigator.pop(context);
                        taskTitle.clear();
                        taskDescription.clear();
                        setState(() {
                          selectedCategory = "Work";
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ),
                      shadowColor: Colors.black,
                      elevation: 5,
                    ),
                    child: Text('Save',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ),
                      shadowColor: Colors.black,
                      elevation: 5,
                    ),
                    child: Text('Cancel',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  )
                ],
              );
            },
          );
        },
        child: Icon(Icons.add, size: 30),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: getDropdownOfCategory(category),
          ),
          Expanded(
            child: FutureBuilder(
              future: database.selectAllTasksUsingJoin(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return snapshot.data![index]['task_status'] == 0
                          ? Card(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              elevation: 6,
                              shadowColor: Colors.black.withOpacity(0.2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data![index]['task_title'],
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87),
                                          ),
                                          SizedBox(height: 6),
                                          Text(
                                            snapshot.data![index]
                                                ['task_description'],
                                            style: TextStyle(
                                                color: Colors.grey[600]),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            'Category: ${snapshot.data![index]['category_name']}',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Colors.cyan),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            'Status: ${snapshot.data![index]['task_status'] == 0 ? "Pending" : "Completed"}',
                                            style: TextStyle(
                                                color: snapshot.data![index]
                                                            ['task_status'] ==
                                                        0
                                                    ? Colors.orange
                                                    : Colors.green),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            taskTitle.text = snapshot
                                                .data![index]['task_title'];
                                            taskDescription.text =
                                                snapshot.data![index]
                                                    ['task_description'];
                                            taskCategory.text = snapshot
                                                .data![index]['category_name'];

                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  title: Text(
                                                    'Edit Task',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 22),
                                                  ),
                                                  content:
                                                      SingleChildScrollView(
                                                    // Allow scrolling if the content exceeds height
                                                    child: Form(
                                                      key: _key,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        // Ensure minimal height
                                                        children: [
                                                          getTextFormField(
                                                              'Task Title',
                                                              taskTitle),
                                                          getTextFormField(
                                                              'Task Description',
                                                              taskDescription),
                                                          getDropdownOfCategory(predefinedCategories),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  actions: [
                                                    ElevatedButton(
                                                      onPressed: () async {
                                                        if (_key.currentState
                                                                ?.validate() ??
                                                            false) {
                                                          Database db =
                                                              await database
                                                                  .initDatabase();
                                                          int categoryId;

                                                          // Handle category logic for Edit Task
                                                          if (selectedCategory ==
                                                              'Other') {
                                                            List<
                                                                    Map<String,
                                                                        dynamic>>
                                                                categories =
                                                                await db.rawQuery(
                                                                    "SELECT category_id FROM Categories WHERE category_name = ?",
                                                                    [
                                                                  taskCategory
                                                                      .text
                                                                ]);

                                                            if (categories
                                                                .isEmpty) {
                                                              await database
                                                                  .insertCategory(
                                                                      taskCategory
                                                                          .text);
                                                              categories =
                                                                  await db
                                                                      .rawQuery(
                                                                "SELECT category_id FROM Categories WHERE category_name = ?",
                                                                [
                                                                  taskCategory
                                                                      .text
                                                                ],
                                                              );
                                                            }

                                                            if (categories
                                                                .isNotEmpty) {
                                                              categoryId = categories
                                                                      .first[
                                                                  "category_id"];
                                                            } else {
                                                              print(
                                                                  "Error: Category insertion failed.");
                                                              return;
                                                            }
                                                          } else {
                                                            List<
                                                                    Map<String,
                                                                        dynamic>>
                                                                categories =
                                                                await db.rawQuery(
                                                                    "SELECT category_id FROM Categories WHERE category_name = ?", [
                                                              selectedCategory
                                                            ]); // Here selectedCategory should be the selected category

                                                            if (categories
                                                                .isNotEmpty) {
                                                              categoryId = categories
                                                                      .first[
                                                                  "category_id"];
                                                            } else {
                                                              return;
                                                            }
                                                          }

                                                          Map<String, dynamic>
                                                              taskData = {
                                                            "task_title":
                                                                taskTitle.text,
                                                            "task_description":
                                                                taskDescription
                                                                    .text,
                                                            "category_id":
                                                                categoryId,
                                                          };

                                                          // Assuming 'index' and 'snapshot.data!' are correctly passed
                                                          await database.editTask(
                                                              taskData,
                                                              snapshot.data![
                                                                      index]
                                                                  ['task_id']);
                                                          Navigator.pop(
                                                              context);
                                                          setState(() {});
                                                        }
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.cyan,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 12,
                                                                horizontal: 20),
                                                      ),
                                                      child: Text('Save',
                                                          style: TextStyle(
                                                              fontSize: 16)),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          icon: Icon(Icons.edit,
                                              color: Colors.cyan),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  title: Text('Delete Task'),
                                                  content: Text(
                                                      'Are you sure you want to delete?'),
                                                  actions: [
                                                    ElevatedButton(
                                                      onPressed: () async {
                                                        int taskId = snapshot
                                                                .data![index]
                                                            ['task_id'];
                                                        print(
                                                            "Attempting to delete task with ID: $taskId");

                                                        await database
                                                            .deleteTask(taskId);

                                                        print(
                                                            "Task deleted successfully");
                                                        Navigator.pop(context);
                                                        setState(
                                                            () {}); // Refresh UI
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.red,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          vertical: 12,
                                                          horizontal: 20,
                                                        ),
                                                      ),
                                                      child: Text('Delete',
                                                          style: TextStyle(
                                                              fontSize: 16)),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('Cancel',
                                                          style: TextStyle(
                                                              fontSize: 16)),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          icon: Icon(Icons.delete,
                                              color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox.shrink();
                    },
                  );
                } else {
                  return Center(child: Text('No tasks found.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  getTextFormField(String label, TextEditingController textController) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: textController,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  getDropdownOfCategory(List<String> list) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            value: selectedCategory,
            items: list
                .map((category) => DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedCategory = value!;
                isOtherSelected = value == "Other";
              });
            },
            decoration: InputDecoration(
              labelText: "Category",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            ),
          ),
          if (isOtherSelected)
            getTextFormField("Custom Category", taskCategory),
        ],
      ),
    );
  }
}
