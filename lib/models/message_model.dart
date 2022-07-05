import 'package:flutter/material.dart';

class MessageModel extends ChangeNotifier {
  String? _message;
  String? _user;
  List<Message> _list = [];

  setMessage(String message, String user) {
    _message = message;
    _user = user;
    _list.add(Message(message: message, user: user));
    notifyListeners();
  }

  String get message => _message!;
  List<Message> get list => _list;
  String get user => _user!;
}

class Message {
  String? message;
  String? user;
  Message({required this.message, required this.user});
}
