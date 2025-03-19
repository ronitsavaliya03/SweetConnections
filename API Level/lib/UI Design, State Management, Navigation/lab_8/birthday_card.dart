import 'package:flutter/material.dart';

class BirthdayCard extends StatefulWidget {
  const BirthdayCard({super.key});

  @override
  State<BirthdayCard> createState() => _BirthdayCardState();
}

class _BirthdayCardState extends State<BirthdayCard> {
  TextEditingController pc = TextEditingController();
  String value = "";
  String imagePath = ''; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Colors.lightBlueAccent, Colors.cyanAccent, Colors.blueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Column(
          children: [
            Text(
              "Something special for you",
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: pc,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  label: Text(
                    "Your Name",
                  ),
                  labelStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 30, color: Colors.teal),
            ),
            if (imagePath.isNotEmpty)
              Image.asset(
                imagePath,
                fit: BoxFit.contain,
                height: 500,
                width: 500,
              ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                print("click Button: ${pc.text}");

                setState(() {
                  value = "Happy Birthday to you " + pc.text;
                  imagePath =
                      "assets/images/img_3.png";
                });
              },
              child: Text("Click"),
            ),
          ],
        ),
      ),
    );
  }
}
