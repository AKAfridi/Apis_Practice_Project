import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';


class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String email, password) async{

    try{
      Response response = await post(
        Uri.parse('https://reqres.in/api/login'),
        body: {
          'email':email,
          'password':password,
        }
      );
      if(response.statusCode==200){
        var data = jsonDecode(response.body.toString());
        print(data);
        print('Login SUccessfully');
      }
      else{
        print('Failed');
      }
    }

    catch(e){
      print(e.toString());

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center
            ,crossAxisAlignment:CrossAxisAlignment.center,
          children: [

          TextFormField(controller: emailController,
            decoration: InputDecoration(
              hintText: 'Email'
            ),
          ),
            SizedBox(height: 10,),
            TextFormField(controller: passwordController,
            decoration: InputDecoration(
              hintText: 'Password',


            ),

          ),
            SizedBox(height: 50,),
            GestureDetector(
              onTap: (){
                login(emailController.text.toString(),
                 passwordController.text.toString());},
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green,
                ),
                child: Center(child: Text('SignUp')),
              ),
            )






        ],),
      ),
    );
  }
}
