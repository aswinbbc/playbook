import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:playbook/models/post_model.dart';

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
              final json = jsonDecode(snapshot.data!);
              Post post = Post.fromJson(json);
              return Text(post.body!);
            } else if (snapshot.hasError) {
              return const Icon(Icons.close);
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Future<String> getData() async {
    http.Response response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/posts/1"));

    log(response.statusCode.toString());
    log(response.body);

    // Map<String, dynamic> json = jsonDecode(response.body);

    return response.body;
  }
}

sample() {
  List<int> intList = [1, 2, 4, 5, 8, 7];
  List<int> resultList = intList.map((singleInt) => singleInt * 2).toList();
}
