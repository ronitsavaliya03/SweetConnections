import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  TextEditingController phoneController=TextEditingController();
  TextEditingController phoneController2=TextEditingController();

  String value='';
  String value2="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomWidget(title: "Loaf n' latte", font: 40),
          Text(value, style: TextStyle(fontSize: 30, color: Colors.teal),),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: phoneController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Your Name")
              ),
            ),
          ),
          Text(value2, style: TextStyle(fontSize: 20, color: Colors.cyan),),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: phoneController2,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Tell Me About Yourself")
              ),
            ),
          ),
          ElevatedButton(onPressed: (){
            print("click Button: ${phoneController.text}");
            print("click Button: ${phoneController2.text}");

            setState(() {
              value=phoneController.text;
              value2=phoneController2.text;
            });
          }, child: Text("Click"))
        ],
      )
    );
  }
}

Widget CustomWidget({required title, required font}){
  return Text(title, style: TextStyle(fontSize: font, color: Colors.amber));
}