import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Constant/reusableRow.dart';
import 'Models/UserModel.dart';

class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
  List<UserModel> user_model = [];

  Future<List<UserModel>> userModel() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        user_model.add(UserModel.fromJson(i));
      }
      return user_model;
    } else {
      return user_model;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: FutureBuilder(
              future:userModel(),
              builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
            return ListView.builder(itemCount:user_model.length,
                itemBuilder: (context, index){
                 return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        ReusableRow( title: 'Name',value: snapshot.data![index].name.toString()),
                        ReusableRow( title: 'UserName',value: snapshot.data![index].username.toString()),
                        ReusableRow( title: 'Email',value: snapshot.data![index].email.toString()),
                        ReusableRow( title: 'Address',value: snapshot.data![index].address!.city.toString()),
                        ReusableRow( title: 'Geo',value: snapshot.data![index].address!.geo!.lat.toString()),


                      ],),
                    ),
                  );
                }

            );
          }),
          )
        ],
      ),
    );
  }
}
