import 'package:flutter/material.dart';
import 'package:new_flutter_labs/UI%20Design,%20State%20Management,%20Navigation/lab_9/Tabs/about.dart';
import 'package:new_flutter_labs/UI%20Design,%20State%20Management,%20Navigation/lab_9/Tabs/contact.dart';
import 'package:new_flutter_labs/UI%20Design,%20State%20Management,%20Navigation/lab_9/Tabs/home.dart';


class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int select = 0;
  List<Widget> pages = [Home(), Contact(), About()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BottomNavBar",
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: pages[select],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              select = value;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.phone), label: "Contact"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined), label: "About")
          ]),
    );
  }
}
