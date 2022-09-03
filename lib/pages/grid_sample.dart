import 'package:flutter/material.dart';

class GridSample extends StatefulWidget {
  GridSample({Key? key}) : super(key: key);

  @override
  State<GridSample> createState() => _GridSampleState();
}

class _GridSampleState extends State<GridSample> {
  List genresColorsList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          crossAxisSpacing: 3,
          mainAxisSpacing: 10,
          children: [
            for (var i = 0; i < genresColorsList.length; i++)
              Expanded(
                child: Container(
                  height: 75,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          // color:
                          //     genresColorsList[i]['color'].toString().toColor(),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 50,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(color: Colors.brown),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              genresColorsList[i]['genre'],
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ]),
    );
  }
}
