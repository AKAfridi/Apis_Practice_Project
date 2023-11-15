import 'dart:convert';

import 'package:api_course/Constant/reusableRow.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Example_Four extends StatefulWidget {
  const Example_Four({super.key});

  @override
  State<Example_Four> createState() => _Example_FourState();
}

class _Example_FourState extends State<Example_Four> {
  var data;
  Future<void> getUserAPI() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getUserAPI(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: Container(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator(
                              color: Colors.red,
                              strokeWidth: 10,
                            )));
                  } else {
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  ReusableRow(
                                    title: 'Name',
                                    value: data[index]['name'].toString(),
                                  ),
                                  ReusableRow(
                                    title: 'UserName',
                                    value: data[index]['username'].toString(),
                                  ),
                                  ReusableRow(
                                    title: 'Email',
                                    value: data[index]['email'].toString(),
                                  ),
                                  Text('Address'),
                                  ReusableRow(
                                    title: 'Street',
                                    value: data[index]['address']['street'].toString(),
                                  ),
                                  ReusableRow(
                                    title: 'Apartment',
                                    value: data[index]['address']['suite'].toString(),
                                  ),
                                  ReusableRow(
                                    title: 'City',
                                    value: data[index]['address']['city'].toString(),
                                  ),
                                  ReusableRow(
                                    title: 'Geo',
                                    value: data[index]['address']['geo'].toString(),
                                  ),

                                ],
                              ),
                            ),
                          );
                        });
                  }
                }),
          )
        ],
      ),
    );
  }
}
