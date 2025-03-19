import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_labs/Scrollable%20Widgets,%20Dialogs%20&%20State%20Management/lab_11/user_list_page.dart';
import 'package:new_flutter_labs/UI%20Design,%20State%20Management,%20Navigation/lab_10/validation.dart';
import 'package:new_flutter_labs/UI%20Design,%20State%20Management,%20Navigation/lab_9/Tabs/about.dart';
import 'package:new_flutter_labs/UI%20Design,%20State%20Management,%20Navigation/lab_9/Tabs/contact.dart';
import 'package:new_flutter_labs/UI%20Design,%20State%20Management,%20Navigation/lab_9/Tabs/home.dart';


class TabViewDemo extends StatefulWidget {
  const TabViewDemo({super.key});

  @override
  State<TabViewDemo> createState() => _TabViewDemoState();
}

class _TabViewDemoState extends State<TabViewDemo> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 3, child: Scaffold(
      appBar: AppBar(
        bottom: TabBar(tabs: [
          Tab(
            text: "Home",
          ),
          Tab(
            text: "Contact",
          ),
          Tab(
            text: "About",
          ),
        ]),
        actions: [
          IconButton(onPressed: () {
            showDialog(context: context, builder: (context) {
              return CupertinoAlertDialog(
                title: Text('Log Out'),
                content: Text('Are you sure want to logout?'),
                actions: [
                  TextButton(onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Validation()));
                  }, child: Text("Ok")),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancel"))
                ],
              );
            });
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: TabBarView(children: [Home(), Contact(), About()]),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(child: Text("Index")),
            ListTile(
              title: Text("Home"),
              leading: Icon(Icons.home_outlined),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Home(),
                ));
              },
            ),
            ListTile(
              title: Text("List of Students"),
              leading: Icon(Icons.supervised_user_circle_outlined),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UserListPage(),
                ));
              },
            ),
            ListTile(
              title: Text("About"),
              leading: Icon(Icons.account_circle_outlined),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => About(),
                ));
              },
            ),
            ListTile(
              title: Text("Contact"),
              leading: Icon(Icons.contact_support_outlined),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Contact(),
                ));
              },
            )
          ],
        ),
      ),
    ));
  }
}
