import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial_app/screens/add_user.dart';
import 'package:matrimonial_app/screens/information.dart';
import 'package:matrimonial_app/screens/user_list.dart';
import 'package:matrimonial_app/user%20model/constants.dart';

import '../api service/api_service.dart';
import '../database/my_database.dart';
import '../user model/user.dart';

class FavoriteUserList extends StatefulWidget {
  const FavoriteUserList({super.key});

  @override
  State<FavoriteUserList> createState() => _FavoriteUserListState();
}

class _FavoriteUserListState extends State<FavoriteUserList> {
  final TextEditingController searchDetails = TextEditingController();
  List<Map<String, dynamic>> favoriteUsers = [];
  List<dynamic> _userList = []; // List to store user data from API

  @override
  void initState() {
    super.initState();
    fetchFavoriteUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      final result = await apiService.getUsers(context);

      if (result is List<dynamic>) {
        setState(() {
          _userList = result;
          user.userList = _userList.cast<Map<String, dynamic>>().toList(); // Update global user list
          isApiCall = false;
        });
      } else {
        // Handle error from API call
        print('Error fetching users: $result');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load users: $result')));
      }
    } catch (e) {
      // Handle any exceptions during API call
      print('Exception fetching users: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred: $e')));
    }
  }

  Future<void> fetchFavoriteUsers() async {
    final dynamic allUsers = await apiService.getUsers(context);

    if (allUsers is List) {
      setState(() {
        favoriteUsers = allUsers
            .map((user) => Map<String, dynamic>.from(user))
            .where((user) => user[ISLIKED] != null && user[ISLIKED].toString() == '1') // Correct null handling and string comparison
            .toList();
      });
    } else {
      print("Unexpected data format: $allUsers");
    }
  }

  void searchUsers(String query) {
    setState(() {
      favoriteUsers = favoriteUsers
          .where((u) => u[NAME].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Candidates", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 136, 14, 79),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: searchDetails,
              onChanged: searchUsers,
              decoration: InputDecoration(
                hintText: 'Search favorite candidates...',
                prefixIcon: Icon(Icons.search),
                suffixIcon: searchDetails.text.isNotEmpty
                    ? IconButton(
                  onPressed: () {
                    setState(() {
                      searchDetails.clear();
                      fetchFavoriteUsers();
                    });
                  },
                  icon: Icon(Icons.cancel_outlined, size: 20),
                )
                    : null,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 15),
            favoriteUsers.isEmpty
                ? Expanded(
              child: Center(
                  child: Text(
                    'No Favorite Candidate Found',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  )),
            )
                : Expanded(
              child: ListView.builder(
                itemCount: favoriteUsers.length,
                itemBuilder: (context, index) {
                  return userCard(favoriteUsers[index]);
                },
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
                        bool isLiked = userData[ISLIKED] == '1';

                        if(isLiked){
                          showDialog(
                            context: context,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: const Text('Unlike'),
                                content:
                                const Text('Are you sure want to unlike?'),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      await _toggleLikeStatus(userData[ID], !isLiked);
                                      await fetchFavoriteUsers();
                                      await _fetchUsers();
                                      setState(()  {
                                        userData[ISLIKED] = isLiked ? '0' : '1'; // Toggle the status
                                        print("ok");
                                        print(userData);
                                      });
                                    },
                                    child: const Text('Yes'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('No'),
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
                            // userData[ISLIKED] = !isLiked ? '1' : '0'; // Toggle the status immediately
                          });
                        }
                      },
                      icon: Icon(
                        userData[ISLIKED] == '1' ? Icons.favorite : Icons.favorite_border,
                        color: userData[ISLIKED] == '1' ? Colors.red : Colors.grey,
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

                            //updatedUser[ISLIKED] = '1'; //COMMENT OUT THIS LINE

                            await apiService.updateUser(context: context, id: updatedUser[ID], map: updatedUser); // Update the database
                            await fetchFavoriteUsers(); // Refresh UI
                            _fetchUsers();

                          }
                        } else if (value == 'delete') {
                          // Use a local variable to store the context
                          BuildContext dialogContext = context;
                          showDialog(
                            context: dialogContext, // Use the local context
                            builder: (context) => CupertinoAlertDialog(
                              title: Text('Delete'),
                              content: Text('Are you sure you want to delete?'),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    await apiService.deleteUser(context: context, id:  userData[ID]);
                                    await fetchFavoriteUsers();
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

  Future<void> _toggleLikeStatus(dynamic userId, bool newStatus) async {
    try {
      // Optimistically update the UI only after API success
      final result = await apiService.updateUser(
        id: userId,
        map: {ISLIKED: newStatus ? '1' : '0'},
        context: context,
      );

      if (result is Map<String, dynamic>) {
        // API success - Update the local user list
        final userIndex = _userList.indexWhere((user) => user[ID] == userId);
        if (userIndex != -1) {
          _userList[userIndex][ISLIKED] = newStatus ? '1' : '0';
        }

        // Refresh UI only after successful API call
        await fetchFavoriteUsers();
        setState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update like status: $result')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

}