import 'package:flutter/material.dart';


class Design extends StatelessWidget {
  // const Demo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Hello buddy!"), backgroundColor: Colors.lightBlueAccent,),
        body: Row(
          children: [
            Expanded(child: Column(
              children: [
                Expanded(child: Container(color: Colors.purpleAccent,)),
                Expanded(child: Container(color: Colors.amber)),
                Expanded(child: Container(color: Colors.purple,))
              ],
            )),
            Expanded(child: Column(
              children: [
                Expanded(child: Container(color: Colors.pink,)),
                Expanded(child: Container(color: Colors.blue)),
                Expanded(child: Container(color: Colors.cyanAccent,))
              ],
            )),
            Expanded(child: Column(
              children: [
                Expanded(child: Container(color: Colors.cyan,)),
                Expanded(child: Container(color: Colors.deepPurpleAccent)),
                Expanded(child: Container(color: Colors.greenAccent,))
              ],
            ))
          ],
        )
    );
  }
}
