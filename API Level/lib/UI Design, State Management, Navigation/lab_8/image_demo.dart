import 'package:flutter/material.dart';

class ImageDemo extends StatelessWidget {
  const ImageDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/img_1.png",
            fit: BoxFit.contain,
          ),
          Positioned(
              right: 600,
              bottom: 0,
              child: Text(
                "Fast & Furious",
                style: TextStyle(fontSize: 50, color: Colors.white),
              )),
          Positioned(
              right: 550,
              top: 0,
              child: Text(
                "Your respect is good enough for me!",
                style: TextStyle(fontSize: 25, color: Colors.white),
              )),
          Positioned(
            right: 58,
            top: 0,
            child: Container(
              height: 100,
              width: 300,
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/img_2.png"))),
            ),
          )
        ],
      ),
    );
  }
}
