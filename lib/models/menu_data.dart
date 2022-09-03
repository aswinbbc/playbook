import 'package:flutter/material.dart';

class MenuData {
  IconData icon;
  String title;
  VoidCallback function;
  MenuData(this.title, this.icon, this.function);
}

List<MenuData> sampleData = [
  MenuData("health", Icons.access_alarm_rounded, () {}),
  MenuData("title", Icons.abc_rounded, () {}),
];
