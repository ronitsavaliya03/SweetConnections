import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial_app/user%20model/constants.dart';
import 'package:matrimonial_app/user%20model/user.dart';
import 'package:matrimonial_app/screens/add_user.dart';
import 'package:matrimonial_app/screens/information.dart';
import '../database/my_database.dart';

User user = User();
enum SortOption { byDefault, nameAZ, nameZA, cityAZ, cityZA }

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final TextEditingController searchDetails = TextEditingController();

  SortOption? _selectedSort;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  // Fetch users from the database
  Future<void> _fetchUsers() async {
    final allUsers = await DatabaseHelper.instance.getAllUsers();
    setState(() {
      user.userList = allUsers;
    });
  }


  List<Map<String, dynamic>> get filteredUsers {
    List<Map<String, dynamic>> users = List.from(user.userList); // Create a modifiable copy

    if (searchDetails.text.isNotEmpty) {
      final query = searchDetails.text.toLowerCase();
      users = users.where((u) {
        return u[NAME].toLowerCase().contains(query) ||
            u[CITY].toLowerCase().contains(query) ||
            u[PHONE].toLowerCase().contains(query);
      }).toList();
    }

    // Apply Sorting
    switch (_selectedSort) {
      case SortOption.byDefault:
        users;
        break;
      case SortOption.nameAZ:
        users.sort((a, b) => b[NAME].compareTo(a[NAME]));
        break;
      case SortOption.nameZA:
        users.sort((a, b) => a[NAME].compareTo(b[NAME]));
        break;
      case SortOption.cityAZ:
        users.sort((a, b) => b[CITY].compareTo(a[CITY]));
        break;
      case SortOption.cityZA:
        users.sort((a, b) => a[CITY].compareTo(b[CITY]));
        break;
      default:
        break;
    }

    return users;
  }

  String _getSortLabel(SortOption option) {
    switch (option) {
      case SortOption.byDefault:
        return "Default";
      case SortOption.nameAZ:
        return "📖 Name: A → Z";
      case SortOption.nameZA:
        return "📖 Name: Z → A";
      case SortOption.cityAZ:
        return "🌍 City: A → Z";
      case SortOption.cityZA:
        return "🌍 City: Z → A";
      default:
        return "🔽 Sort Options";
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Candidate List",
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 136, 14, 79),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 20),
            TextFormField(
              controller: searchDetails,
              onChanged: (value) {
                setState(() {}); // Refresh UI when text changes
              },
              decoration: InputDecoration(
                hintText: 'Search people & places',
                prefixIcon: Icon(Icons.search_rounded, size: 25),
                suffixIcon: searchDetails.text.isNotEmpty
                    ? IconButton(
                  onPressed: () {
                    setState(() {
                      searchDetails.clear();
                    });
                  },
                  icon: Icon(Icons.cancel_outlined, size: 20),
                )
                    : null, // Hide suffix icon when text is empty
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: 8,),
                    Icon(Icons.sort),
                    SizedBox(width: 8,),
                    Text(
                      "Sort By:",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                DropdownButton<SortOption>(
                  value: _selectedSort,
                  hint: Text("Select"),
                  onChanged: (SortOption? newValue) {
                    setState(() {
                      _selectedSort = newValue;
                    });
                  },
                  items: SortOption.values.map((sortOption) {
                    return DropdownMenuItem(
                      value: sortOption,
                      child: Text(_getSortLabel(sortOption)),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 10),

            filteredUsers.isEmpty
                ? Expanded(
              child: Center(
                  child: Text(
                    'No Candidate Found',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  )),
            )
                : Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return userCard(filteredUsers.reversed.toList()[index]);
                },
                itemCount: filteredUsers.length,
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget userCard(Map<String, dynamic> userData) {
    return InkWell(
      onTap: () {
        int index = user.userList.indexWhere((u) => u[ID] == userData[ID]);
        if (index != -1) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Information(i: index), // Pass index instead of userData
          ));
        }
      },

      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.pinkAccent.shade100,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: Text(
                  userData[NAME],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '${userData[AGE]} years',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () async {
                        bool isLiked = userData[ISLIKED] == 1;

                        if(isLiked){
                          showDialog(
                            context: context,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: Text('Unlike'),
                                content:
                                Text('Are you sure want to unlike?'),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      await _toggleLikeStatus(userData[ID], !isLiked);
                                      await _fetchUsers();
                                      setState(()  {
                                          // userData[ISLIKED] = isLiked ? 0 : 1; // Toggle the status
                                        print("ok");
                                        print(userData);
                                      });
                                    },
                                    child: Text('Yes'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('No'),
                                  )
                                ],
                              );
                            },
                          );
                        }
                        else{
                          await _toggleLikeStatus(userData[ID], !isLiked);
                          await _fetchUsers();
                          setState(() {
                            // userData[ISLIKED] = !isLiked ? 1 : 0; // Toggle the status immediately
                          });
                        }
                      },
                      icon: Icon(
                        userData[ISLIKED] == 1 ? Icons.favorite : Icons.favorite_border,
                        color: userData[ISLIKED] == 1 ? Colors.red : Colors.grey,
                      ),
                    ),
                    PopupMenuButton(
                      icon: Icon(Icons.more_vert),
                      onSelected: (value) async {
                        if (value == 'edit') {
                          final updatedUser = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEditScreen(data: Map<String, dynamic>.from(userData)), // Pass data to screen
                            ),
                          );

                          if (updatedUser != null) {
                            if (!updatedUser.containsKey(ID) || updatedUser[ID] == null) {
                              throw Exception("User ID is missing for update.");
                            }
                            await DatabaseHelper.instance.updateUser(updatedUser);
                            await _fetchUsers();
                          }

                        } else if (value == 'delete') {
                          showDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                              title: Text('Delete'),
                              content:
                              Text('Are you sure you want to delete?'),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    _deleteUser(userData[ID]);
                                    await _fetchUsers();

                                    Navigator.pop(context);
                                  },
                                  child: Text('Yes'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('No'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit),
                              SizedBox(width: 6),
                              Text("Edit")
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.red),
                              SizedBox(width: 6),
                              Text("Delete")
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.orange),
                            SizedBox(width: 6),
                            Text(userData[CITY]),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.phone, color: Colors.green),
                            SizedBox(width: 6),
                            Text(userData[PHONE]),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.email, color: Colors.pink),
                        SizedBox(width: 6),
                        Text(userData[EMAIL]),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _toggleLikeStatus(int userId, bool newStatus) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      User.tableName,
      {ISLIKED: newStatus ? 1 : 0},
      where: '$ID = ?',
      whereArgs: [userId],
    );
  }

  Future<void> _deleteUser(int userId) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete(
      User.tableName,
      where: '$ID = ?',
      whereArgs: [userId],
    );

    setState(() {
      user.userList.removeWhere((u) => u[ID] == userId);
    });
  }
}
