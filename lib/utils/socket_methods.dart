import 'package:flutter/material.dart';
import 'package:playbook/models/message_model.dart';
import 'package:playbook/pages/chat_page.dart';
import 'package:playbook/pages/container_game.dart';
import 'package:playbook/utils/socket_io_client.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  Socket get socketClient => _socketClient;

  // EMITS
  void createRoom(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit('createRoom', {
        'nickname': nickname,
      });
    }
  }

  void joinRoom(String nickname, String roomId) {
    if (nickname.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('joinRoom', {
        'nickname': nickname,
        'roomId': roomId,
      });
    }
  }

  void sendMessage(String message, user, roomId) {
    if (message.isNotEmpty) {
      _socketClient.emit('send_message', {
        'message': message,
        'user': user,
        'roomId': roomId,
      });
    }
  }

  void coverArea(user, roomId) {
    _socketClient.emit('change_area', {
      'user': user,
      'roomId': roomId,
    });
  }

  // LISTENERS
  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on('createRoomSuccess', (data) {
      final json = data;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ContainerGame(
                name: json['nickname'],
                roomId: json['roomId'],
              )));
    });
  }

  void messageListener(BuildContext context) {
    _socketClient.on('new_message', (data) {
      Provider.of<MessageModel>(context, listen: false)
          .setMessage(data['message'], data['user']);
    });
  }

  void areaListener(BuildContext context, Function(String) areaChanged) {
    _socketClient.on('area_changed', (data) {
      areaChanged(data['user']);
    });
  }
}
