import 'package:flutter/material.dart';

class NavigationDemo extends StatefulWidget {
  const NavigationDemo({super.key});

  @override
  State<NavigationDemo> createState() => _NavigationDemoState();
}

class _NavigationDemoState extends State<NavigationDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Navigation Demo", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(onPressed: (){
              Navigator.of(context).pushNamed('/home', arguments: 'asdf');
            }, child: Text("Home")),
          ),
          SizedBox(width: 20,),
          Center(
            child: ElevatedButton(onPressed: (){
              Navigator.of(context).pushNamed('/contact', arguments: 'qwer');
            }, child: Text("Contact")),
          ),
          SizedBox(width: 20,),
          Center(
            child: ElevatedButton(onPressed: (){
              Navigator.of(context).pushNamed('/about', arguments: 'asdf');
            }, child: Text("About")),
          ),
        ],
      )
    );
  }
}
