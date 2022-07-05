import 'package:flutter/material.dart';
import 'package:playbook/utils/socket_methods.dart';

class CreateGame extends StatefulWidget {
  const CreateGame({Key? key}) : super(key: key);

  @override
  State<CreateGame> createState() => _CreateGameState();
}

class _CreateGameState extends State<CreateGame> {
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        TextField(controller: _nameController),
        ElevatedButton(onPressed: onPressed, child: Text("Create Room"))
      ]),
    );
  }

  void onPressed() {
    SocketMethods().createRoom(_nameController.text);
  }
}
