import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial_app/user%20model/constants.dart';
import 'package:matrimonial_app/user%20model/user.dart';
import 'package:matrimonial_app/screens/add_user.dart';
import 'package:matrimonial_app/screens/information.dart';

User user = User();
// List<Map<String, dynamic>> favoriteUsers=[];

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final TextEditingController searchDetails = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: searchDetails,
              onChanged: (value) {
                user.searchDeatil(searchData: value);
                setState(() {});
              },
              decoration: InputDecoration(
                  hintText: 'Search people & places',
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    size: 25,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        searchDetails.clear();
                      });
                    },
                    icon: Icon(Icons.cancel_outlined, size: 20,),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12))),
            ),
            SizedBox(
              height: 15,
            ),
            user.display().isEmpty ||
                    (searchDetails.text != '' && user.searchResultList.isEmpty)
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
                        print(':::LISTVIEW ITEM BUILDER CALLED:::$index');
                        return userCard(index);
                      },
                      itemCount: searchDetails.text == ''
                          ? user.userList.length
                          : user.searchResultList.length,
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget userCard(int i) {
    return InkWell(
      onTap: () {
        int userIndex = searchDetails.text == ''
            ? i
            : user.userList.indexOf(user.searchResultList[i]);

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Information(i: userIndex),
        ));
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
                    searchDetails.text == ''
                        ? user.userList[i][NAME]
                        : user.searchResultList[i][NAME],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    searchDetails.text == ''
                        ? '${user.userList[i][AGE]} years'
                        : '${user.searchResultList[i][AGE]} years',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: (() {
                            if (user.userList[i][ISLIKED] == false) {
                              setState(() {
                                user.userList[i][ISLIKED] = true;
                              });
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return CupertinoAlertDialog(
                                    title: Text('Unlike'),
                                    content:
                                        Text('Are you sure want to unlike?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          setState(() {
                                            user.userList[i][ISLIKED] = false;
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
                          }),
                          icon: !user.userList[i][ISLIKED]
                              ? Icon(
                                  Icons.favorite_border,
                                  color: Colors.grey,
                                )
                              : Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )),
                      PopupMenuButton(
                        icon: Icon(Icons.more_vert),
                        onSelected: (value) {
                          if (value == 'edit') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddEditScreen(data: user.userList[i]),
                              ),
                            ).then((updatedUser) {
                              if (updatedUser != null) {
                                user.userList[i] = updatedUser;
                              }
                            });
                          } else if (value == 'delete') {
                            showDialog(
                              context: context,
                              builder: (context) => CupertinoAlertDialog(
                                title: Text('Delete'),
                                content:
                                    Text('Are you sure you want to delete?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        user.deleteUser(
                                            id: i); // Ensure the UI is updated
                                      });
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
                                SizedBox(
                                  width: 6,
                                ),
                                Text("Edit")
                              ],
                            ),
                          ),
                          PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text("Delete")
                                ],
                              )),
                        ],
                      ),
                    ],
                  )),
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
                            Text(searchDetails.text == ''
                                ? user.userList[i][CITY]
                                : user.searchResultList[i][CITY],),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.phone, color: Colors.green),
                            SizedBox(width: 6),
                            Text(searchDetails.text == ''
                                ? user.userList[i][PHONE]
                                : user.searchResultList[i][PHONE],),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.email, color: Colors.pink),
                        SizedBox(width: 6),
                        Text(searchDetails.text == ''
                            ? user.userList[i][EMAIL]
                            : user.searchResultList[i][EMAIL],),
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
