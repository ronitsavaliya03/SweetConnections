import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:new_flutter_labs/Static%20CRUD/constants.dart';
import 'package:new_flutter_labs/Static%20CRUD/user.dart';
import 'package:new_flutter_labs/UI%20Design,%20State%20Management,%20Navigation/lab_7/userEntryForm.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  User _user = User();

  TextEditingController searchDetails = TextEditingController();
  bool isGrid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Students\' Profiles',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isGrid = !isGrid; // Toggle between Grid and List
              });
            },
            icon: Icon(
              isGrid ? Icons.list : Icons.grid_3x3,
              color: Colors.white,
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return UserEntryFormPage();
                  },
                )).then((value) {
                  _user.userList.add(value);
                  setState(() {});
                });
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              )),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: searchDetails,
            onChanged: (value) {
              _user.searchDeatil(searchData: value);
              setState(() {});
            },
            decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(
                  Icons.search_rounded,
                  size: 25,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12))),
          ),
          SizedBox(
            height: 25,
          ),
          _user.display().isEmpty ||
                  (searchDetails.text != '' && _user.searchResultList.isEmpty)
              ? Expanded(
                  child: Center(
                      child: Text(
                    'No Student Found',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  )),
                )
              : (isGrid
                  ? Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                        itemBuilder: (context, index) {
                          print(':::GRID ITEM BUILDER CALLED:::$index');
                          return getListGridItem(index);
                        },
                        itemCount: searchDetails.text == ''
                            ? _user.userList.length
                            : _user.searchResultList.length,
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          print(':::LISTVIEW ITEM BUILDER CALLED:::$index');
                          return getListGridItem(index);
                        },
                        itemCount: searchDetails.text == ''
                            ? _user.userList.length
                            : _user.searchResultList.length,
                      ),
                    )),
        ],
      ),
    );
  }

  Widget getListGridItem(i) {
    return Card(
      elevation: 10,
      child: ListTile(
        onTap: () {},
        leading: Icon(Icons.account_circle_outlined),
        trailing: Wrap(
          alignment: WrapAlignment.center,
          direction: Axis.horizontal,
          children: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: Text('DELETE'),
                      content: Text('Are you sure want to delete?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            _user.deleteUser(id: i);
                            Navigator.pop(context);
                            setState(() {});
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
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
            IconButton(
                onPressed: (() {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => UserEntryFormPage(
                                data: _user.userList[i],
                              )))
                      .then((value) {
                    if (value != null) {
                      _user.userList[i] = value;
                      setState(() {});
                    }
                  });
                }),
                icon: Icon(Icons.edit))
          ],
        ),
        title: Text(
          searchDetails.text == ''
              ? '${_user.userList[i][NAME]}'
              : '${_user.searchResultList[i][NAME]}',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          searchDetails.text == ''
              ? '${_user.userList[i][EMAIL]} | ${_user.userList[i][CITY]}'
              : '${_user.searchResultList[i][EMAIL]} | ${_user.searchResultList[i][CITY]}',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ),
    );
  }
}
