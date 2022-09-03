import 'package:flutter/material.dart';
import 'package:playbook/models/person.dart';

class SecondPage extends StatelessWidget {
  final Person person;
  const SecondPage({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('${person.name} ${person.age}')),
    );
  }
}
