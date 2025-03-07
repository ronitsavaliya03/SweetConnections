import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial_app/screens/add_user.dart';
import 'package:matrimonial_app/screens/user_list.dart';
import 'package:matrimonial_app/user%20model/constants.dart';
import 'package:matrimonial_app/user%20model/user.dart';
import 'package:matrimonial_app/screens/information.dart';

class FavoriteUserList extends StatefulWidget {
  const FavoriteUserList({super.key});

  @override
  State<FavoriteUserList> createState() => _FavoriteUserListState();
}

class _FavoriteUserListState extends State<FavoriteUserList> {
  final TextEditingController searchDetails = TextEditingController();

  void searchUsers(String query) {
    user.searchDeatil(searchData: query);
    setState(() {}); // Refresh UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorite Candidates",
          style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 136, 14, 79),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            TextFormField(
              controller: searchDetails,
              onChanged: searchUsers,
              decoration: InputDecoration(
                hintText: 'Search favorite candidates...',
                prefixIcon: Icon(Icons.search, size: 25),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      searchDetails.clear();
                      searchUsers('');
                    });
                  },
                  icon: Icon(Icons.cancel_outlined, size: 20),
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: searchDetails.text.isEmpty
                    ? user.userList.where((u) => u[ISLIKED] == true).length
                    : user.searchResultList.where((u) => u[ISLIKED] == true).length,
                itemBuilder: (context, index) {
                  final isSearching = searchDetails.text.isNotEmpty;
                  final userList = isSearching
                      ? user.searchResultList.where((u) => u[ISLIKED] == true).toList()
                      : user.userList.where((u) => u[ISLIKED] == true).toList();

                  return userCard(userList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget userCard(Map<String, dynamic> userData) {
    // Get correct index from the main user list
    int originalIndex = user.userList.indexWhere((u) => u[NAME] == userData[NAME]);

    return InkWell(
      onTap: () {
        if (originalIndex != -1) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Information(i: originalIndex),
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
                      onPressed: () {
                        setState(() {
                          userData[ISLIKED] = !userData[ISLIKED];
                        });
                      },
                      icon: userData[ISLIKED]
                          ? Icon(Icons.favorite, color: Colors.red)
                          : Icon(Icons.favorite_border, color: Colors.grey),
                    ),
                    PopupMenuButton(
                      icon: Icon(Icons.more_vert),
                      onSelected: (value) {
                        if (value == 'edit') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEditScreen(data: userData),
                            ),
                          ).then((updatedUser) {
                            if (updatedUser != null) {
                              setState(() {
                                user.userList[originalIndex] = updatedUser;
                              });
                            }
                          });
                        } else if (value == 'delete') {
                          showDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                              title: Text('Delete'),
                              content: Text('Are you sure you want to delete?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    user.deleteUser(id: originalIndex);
                                    Navigator.pop(context);
                                    setState(() {});
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
}
