import 'package:flutter/material.dart';
import 'package:playbook/models/person.dart';
import 'package:playbook/pages/second_page.dart';

class SampleOne extends StatefulWidget {
  const SampleOne({Key? key}) : super(key: key);

  @override
  State<SampleOne> createState() => _SampleOneState();
}

class _SampleOneState extends State<SampleOne> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        TextField(
          controller: nameController,
        ),
        TextField(
          controller: ageController,
        ),
        ElevatedButton(
            onPressed: () {
              final person = Person(nameController.text, ageController.text);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondPage(person: person),
                  ));
            },
            child: Text("navigate"))
      ]),
    );
  }
}
