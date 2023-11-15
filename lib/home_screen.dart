import 'dart:convert';
import 'package:api_course/Models/post_get_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostGetModel> Postlist = [];
  Future<List<PostGetModel>> getPostApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      Postlist.clear();
      for (Map i in data) {
        Postlist.add(PostGetModel.fromJson(i));
      }
      return Postlist;
    } else {
      return Postlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPostApi(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text('Loding....');
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: Postlist.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text(
                              'Title\n',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),),
                                  Text(
                                    Postlist[index].title.toString()
                                  ),
                                  Text(
                                    'Description\n',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                        Postlist[index].body.toString(),

                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }
}
