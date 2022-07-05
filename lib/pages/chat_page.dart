import 'package:flutter/material.dart';
import 'package:playbook/models/message_model.dart';
import 'package:provider/provider.dart';

import '../utils/socket_methods.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key? key, required this.name, required this.roomId})
      : super(key: key);
  final String name, roomId;
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _codeController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.messageListener(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MessageModel>(
      builder: (context, messageModel, child) => Scaffold(
        appBar: AppBar(title: Text('${widget.name} in ${widget.roomId}')),
        body: Column(children: [
          Row(
            children: [
              Expanded(
                flex: 9,
                child: TextField(
                  controller: _codeController,
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: send,
                  icon: Icon(Icons.send),
                ),
              ),
            ],
          ),
          ListView.builder(
            itemCount: messageModel.list.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(messageModel.list.elementAt(index).message!),
                subtitle: Text(messageModel.list.elementAt(index).user!),
              );
            },
          )
        ]),
      ),
    );
  }

  void send() {
    _socketMethods.sendMessage(
        _codeController.text, widget.name, widget.roomId);
  }
}
