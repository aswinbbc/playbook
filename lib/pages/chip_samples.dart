import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List days = ['sun', 'mon', 'tue', 'wed', 'thur', 'fry', 'sat'];

  @override
  Widget build(BuildContext context) {
    List<String> resultList = [];
    return Scaffold(
      appBar: AppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  child: const Text("Save"),
                  onPressed: () {
                    String result = "";
                    for (var element in resultList) {
                      if (element.isNotEmpty) {
                        if (result.isNotEmpty) {
                          if (element != resultList.last) {
                            result += ", $element";
                          } else {
                            result += "and $element";
                          }

                          log("object: $element ${resultList.last}..");
                        } else {
                          result = element;
                        }
                      }
                    }

                    log(result.replaceAll("(.*), (.*)", " and "));
                  }),
            ),
          ],
        ),
      ),
      body: ListView.separated(
          separatorBuilder: (context, index) => index % 2 != 0
              ? const Divider()
              : const Divider(height: 10, color: Colors.red),
          itemCount: days.length,
          itemBuilder: (context, index) {
            resultList.add("");
            return SingleCard(
              day: days[index],
              status: (status) {
                log("${resultList.length - 1} $index");
                resultList[index] = status;
              },
            );
          }),
    );
  }
}

class SingleCard extends StatefulWidget {
  const SingleCard({Key? key, required this.day, required this.status})
      : super(key: key);
  final String day;
  final Function(String checked) status;
  @override
  State<SingleCard> createState() => _SingleCardState();
}

class _SingleCardState extends State<SingleCard> {
  bool checked = false;
  late String status;

  @override
  void initState() {
    status = "not available${widget.day}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onChanged: (value) => setState(() {
                  checked = value!;
                }),
                value: checked,
              ),
              Center(
                child: Text(
                  widget.day,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ],
          ),
          title: Wrap(
            children: [
              checked
                  ? WeekStrip(
                      changedList: ((value) {
                        status = value.length == 3
                            ? ('${widget.day} wholeday')
                            : ('${widget.day} ${value.join(", ")}');

                        widget.status(status);
                      }),
                    )
                  : const Text("Unavailable"),
            ],
          )),
    );
  }
}

class WeekStrip extends StatefulWidget {
  const WeekStrip({Key? key, required this.changedList}) : super(key: key);
  final Function(List<String>) changedList;
  @override
  State<WeekStrip> createState() => _WeekStripState();
}

class _WeekStripState extends State<WeekStrip> {
  List<String> tags = [];
  List<String> options = [
    'morning',
    'afternoon',
    'evening',
  ];

  @override
  Widget build(BuildContext context) {
    return ChipsChoice<String>.multiple(
      value: tags,
      onChanged: (val) => setState(() {
        tags = val;

        widget.changedList(tags);
      }),
      choiceItems: C2Choice.listFrom<String, String>(
        source: options,
        value: (index, value) => value,
        label: (index, value) => value,
      ),
      choiceActiveStyle: const C2ChoiceStyle(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      choiceStyle: const C2ChoiceStyle(
        showCheckmark: false,
        color: Colors.purple,
        backgroundColor: Colors.white,
        borderColor: Color.fromARGB(255, 36, 25, 187),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      wrapped: true,
    );
  }
}
