import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
                    resultList.forEach(
                      (element) {
                        if (element.isNotEmpty) {
                          if (result.isNotEmpty) {
                            if (element != resultList.last) {
                              result += ", $element";
                            } else {
                              result += "and $element";
                            }

                            print("object: $element ${resultList.last}..");
                          } else {
                            result = element;
                          }
                        }
                      },
                    );

                    print(result.replaceAll("(.*), (.*)", " and "));
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
                // resultList.add(status);
                print("${resultList.length - 1} $index");
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
    status = "not available" + widget.day;
    // widget.status(status);
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
                            ? (widget.day + ' wholeday')
                            : (widget.day + ' ' + value.join(", "));

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
