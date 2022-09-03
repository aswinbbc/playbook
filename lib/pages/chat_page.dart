import 'package:flutter/material.dart';
import 'package:playbook/models/message_model.dart';
import 'package:provider/provider.dart';

import '../utils/socket_methods.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.name, required this.roomId})
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
        appBar: AppBar(
            title: Text('${widget.name} in chatroom : ${widget.roomId}')),
        body: Column(children: [
          Expanded(
            flex: 9,
            child: ListView.builder(
              reverse: true,
              itemCount: messageModel.list.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                // return ListTile(
                //   title: Text(messageModel.list.elementAt(index).message!),
                //   subtitle: Text(messageModel.list.elementAt(index).user!),
                // );
                final bool isMe =
                    messageModel.list.elementAt(index).user! != widget.name;
                return Container(
                  padding:
                      EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                  child: Align(
                    alignment: (isMe ? Alignment.topLeft : Alignment.topRight),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (isMe ? Colors.grey.shade200 : Colors.blue[200]),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: isMe
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            messageModel.list.elementAt(index).user!,
                            style: TextStyle(fontSize: 10),
                          ),
                          Text(
                            messageModel.list.elementAt(index).message!,
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              color: Colors.blueGrey[100],
              child: Row(
                children: [
                  Expanded(
                    flex: 9,
                    child: TextField(
                      decoration: const InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                      controller: _codeController,
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: send,
                      icon: const Icon(Icons.send),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void send() {
    _socketMethods.sendMessage(
        _codeController.text, widget.name, widget.roomId);
    _codeController.clear();
  }
}
