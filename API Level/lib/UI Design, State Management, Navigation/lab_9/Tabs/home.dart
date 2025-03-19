import 'package:flutter/material.dart';
import 'package:new_flutter_labs/UI%20Design,%20State%20Management,%20Navigation/lab_9/Tabs/about.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 0, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                // Aligns the Text widget to the right
                child: Text(
                  'Widget of The Week',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Container(
              height: 135,
              width: 350,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Cotainer",
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Container is a widget that allows you to shape,\ncolour and add borders to anything")
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.lightBlueAccent,
              ),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 0, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                // Aligns the Text widget to the right
                child: Text(
                  'Latest News',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Container(
              height: 150,
              width: 350,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Flutter 1.2",
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Updated Material widgets, performance\nimprovements for Flutter and Dart, and a new\ninteractive widget")
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.deepOrangeAccent,
              ),
            ),
            SizedBox(height: 30,),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => About()));
                },
                child: Text("Next Page"))
          ],
        ),
      ),
    );
  }
}
