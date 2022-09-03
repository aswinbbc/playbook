import 'dart:math' as math;

import 'package:flutter/material.dart';

class MyArc extends StatelessWidget {
  final double diameter;

  const MyArc({Key? key, this.diameter = 200}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.rectangle,
            ),
            height: 35,
            width: 35,
          ),
        ),
      ],
    );
  }
}
