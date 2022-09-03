import 'package:flutter/material.dart';
import 'package:playbook/utils/socket_methods.dart';

class CreateGame extends StatefulWidget {
  const CreateGame({Key? key}) : super(key: key);

  @override
  State<CreateGame> createState() => _CreateGameState();
}

class _CreateGameState extends State<CreateGame> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.createRoomSuccessListener(context);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        TextField(controller: _nameController),
        ElevatedButton(onPressed: onPressed, child: const Text("Create Room")),
        TextField(controller: _nameController),
        TextField(controller: _codeController),
        ElevatedButton(onPressed: joinRoom, child: const Text("Join Room")),
      ]),
    );
  }

  void onPressed() {
    _socketMethods.createRoom(_nameController.text);
  }

  void joinRoom() {
    _socketMethods.joinRoom(_nameController.text, _codeController.text);
  }
}
