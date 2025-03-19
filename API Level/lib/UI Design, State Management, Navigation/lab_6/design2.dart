import 'package:flutter/material.dart';


class Design2 extends StatelessWidget {
  // const Demo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: Text("Hello buddy!"), backgroundColor: Colors.lightBlueAccent,),
        body: Row(
          children: [
            Expanded(child: Column(
              children: [
                Expanded(child: Container(color: Colors.purpleAccent,), flex: 2,),
                Expanded(child: Container(color: Colors.amber), flex:3),
                Expanded(child: Container(color: Colors.purple,), flex:4)
              ],
            )),
            Expanded(child: Column(
              children: [
                Expanded(child: Container(color: Colors.pink,), flex: 4,),
                Expanded(child: Container(color: Colors.blue), flex: 3,),
                Expanded(child: Container(color: Colors.cyanAccent,), flex: 2,)
              ],
            )),
            Expanded(child: Column(
              children: [
                Expanded(child: Container(color: Colors.cyan,)),
                Expanded(child: Container(color: Colors.deepPurpleAccent), flex: 4,),
                Expanded(child: Container(color: Colors.greenAccent), flex: 2)
              ],
            ))
          ],
        )
    );
  }
}
