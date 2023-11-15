import 'package:api_course/ExampleFive.dart';
import 'package:api_course/ExampleFour.dart';
import 'package:api_course/SignUPscreen.dart';
import 'package:api_course/UploadImage.dart';
import 'package:api_course/example_three.dart';
import 'package:api_course/example_two.dart';
import 'package:api_course/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UploadImage(),
    );
  }
}

