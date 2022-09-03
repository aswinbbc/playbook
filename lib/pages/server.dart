import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:socket_io/socket_io.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MyServer extends StatefulWidget {
  const MyServer({Key? key}) : super(key: key);

  @override
  State<MyServer> createState() => _MyServerState();
}

class _MyServerState extends State<MyServer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
            onPressed: connectSocketServer,
            child: const Text('start server'),
          ),
          ElevatedButton(
            onPressed: connectSocket,
            child: const Text('connect server'),
          ),
          ElevatedButton(
            onPressed: () {
              sendMsg();
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) =>
              //           const SocketServer(title: "Socket server"),
              //     ));
            },
            child: const Text('socket server'),
          ),
        ],
      )),
    );
  }

  startServer() async {
    var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8080);
    if (kDebugMode) {
      print(
          "Server running on IP : ${server.address} On Port : ${server.port}");
    }
    await for (var request in server) {
      request.response
        ..headers.contentType = ContentType("text", "plain", charset: "utf-8")
        ..write('Hello, world')
        ..close();
    }
  }

  connectSocket() {
    IO.Socket socket = IO.io('http://localhost:3000');
    socket.on('connect', (_) {
      print('connect');
      socket.emit('msg', 'test');
    });
    socket.on('event', (data) => print(data));
    socket.on('disconnect', (_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
  }

  late Server io;
  sendMsg() {
    io.of('connection').emit('msg', 'howww');
  }

  connectSocketServer() {
    io = Server();
    var nsp = io.of('/some');
    nsp.on('connection', (client) {
      print('connection /some');
      client.on('msg', (data) {
        print('data from /some => $data');
        client.emit('fromServer', "ok 2");
      });
    });
    io.on('connection', (client) {
      print('connection default namespace');
      client.on('msg', (data) {
        print('data from default => $data');
        client.emit('fromServer', "ok");
      });
    });
    io.listen(3000);
  }
}

class SocketServer extends StatefulWidget {
  const SocketServer({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<SocketServer> createState() => _SocketServerState();
}

class _SocketServerState extends State<SocketServer> {
  final TextEditingController _controller = TextEditingController();
  final _channel = WebSocketChannel.connect(
    Uri.parse('wss://localhost:3000/some'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Send a message'),
              ),
            ),
            const SizedBox(height: 24),
            StreamBuilder(
              stream: _channel.stream,
              builder: (context, snapshot) {
                return Text(snapshot.hasData ? '${snapshot.data}' : '');
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: const Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      _channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    _controller.dispose();
    super.dispose();
  }
}
