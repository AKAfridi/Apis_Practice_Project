import 'dart:convert';
import 'package:api_course/Models/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Example_Five extends StatefulWidget {
  const Example_Five({super.key});
  @override
  State<Example_Five> createState() => _Example_FiveState();
}
class _Example_FiveState extends State<Example_Five> {
  Future<ProductModel> getProductModel() async {
    final response = await http.get(
        Uri.parse('https://webhook.site/8218ac7c-e4b6-4c90-afea-593f662aa147'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ProductModel.fromJson(data);
    } else {
      return ProductModel.fromJson(data);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<ProductModel>(
                future: getProductModel(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height*.66,
                        width: MediaQuery.of(context).size.width*1,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ListTile(title: Text(snapshot.data!.data![index].shop!.name.toString()),
                                subtitle: Text(snapshot.data!.data![index].shop!.description.toString()),
                                leading: CircleAvatar(backgroundImage: NetworkImage(snapshot.data!.data![index].shop!.image.toString()),),
                              ),
                              Expanded(
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.data![index].images!.length,
                                    itemBuilder: (context, position) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(height: MediaQuery.of(context).size.height*.6,
                                        width: MediaQuery.of(context).size.width*1,
                                          child: Column(children: [
                                            Image(image: NetworkImage(snapshot.data!.data![index].images![position].url.toString()),),
                                            Text(snapshot.data!.data![index].images![position].id.toString(),style: TextStyle(fontWeight: FontWeight.bold),)
                                          ],)
                                        ),
                                      );
                                    }),
                              ),
                              Icon(snapshot.data!.data![index].inWishlist! == true ? Icons.favorite : Icons.favorite_border_outlined  )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
                }),
          )
        ],
      ),
    );
  }
}
