import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class HttpSample extends StatefulWidget {
  const HttpSample({Key? key}) : super(key: key);

  @override
  State<HttpSample> createState() => _HttpSampleState();
}

class _HttpSampleState extends State<HttpSample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FutureBuilder(
          future: getData(),
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text("error");
            } else {
              return Text("loading..");
            }
          },
        ),
      ),
    );
  }

  Future<String> getData() async {
    http.Response response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/posts/1"));

    print(response.statusCode);
    print(response.body);
    final json = jsonDecode(response.body);
    return json['id'].toString();
  }
}
