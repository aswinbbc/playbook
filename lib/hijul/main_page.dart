import 'package:flutter/material.dart';
import 'header.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(child: Header()),
          Image.asset("images/download.png")
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("images/download.png"),
              color: Color(0xFF3A5A98),
            ),
            label: "ho"),
        BottomNavigationBarItem(
          label: "home",
          icon: Image(
              height: 30,
              image: AssetImage(
                "images/download.png",
              )),
        ),
        BottomNavigationBarItem(
          label: "h",
          icon: ImageIcon(
            AssetImage("images/download.png"),
            // color: Color(0xFF3A5A98),
          ),
        ),
      ]),
    );
  }
}
