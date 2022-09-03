import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/socket_methods.dart';

class ContainerGame extends StatefulWidget {
  final String name, roomId;
  const ContainerGame({Key? key, required this.name, required this.roomId})
      : super(key: key);

  @override
  State<ContainerGame> createState() => _ContainerGameState();
}

class _ContainerGameState extends State<ContainerGame> {
  final SocketMethods _socketMethods = SocketMethods();

  late Timer _timer;
  int _start = 10;
  bool isStarted = false;

  void startTimer() {
    isStarted = false;
    _start = 10;
    enemy = 10;
    me = 10;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            isStarted = true;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    _socketMethods.areaListener(
      context,
      (name) {
        setState(() {
          if (name == widget.name) {
            coverAreaMe();
          } else {
            coverAreaEnemy();
          }
        });
      },
    );
  }

  int enemy = 10;
  int me = 10;
  coverAreaMe() {
    setState(() {
      --enemy;
      ++me;
    });
  }

  coverAreaEnemy() {
    setState(() {
      ++enemy;
      --me;
    });
  }

  checker() {
    if (enemy == 0 || me == 0) {
      startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    checker();
    return Scaffold(
      body: Stack(
        children: [
          Column(children: [
            Expanded(
                flex: enemy,
                child: Container(
                  color: Colors.red,
                )),
            Expanded(
                flex: me,
                child: Container(
                  color: Colors.green,
                )),
          ]),
          Column(children: [
            Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {},
                )),
            Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    if (isStarted)
                      _socketMethods.coverArea(widget.name, widget.roomId);
                  },
                )),
          ]),
          Visibility(
            visible: !isStarted,
            child: Center(
                child: Card(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: GestureDetector(
                  onTap: startTimer,
                  child: Text(
                    "$_start",
                    style: TextStyle(fontSize: 50),
                  ),
                ),
              ),
            )),
          )
        ],
      ),
    );
  }
}
