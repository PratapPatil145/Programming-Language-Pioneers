import 'package:cpl_pioneers/constants.dart';
import 'package:cpl_pioneers/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Computer Programming Language Pioneers',
      theme: ThemeData(
        primarySwatch: Device.primaryColor,
      ),
      home: HomePage(),
    );
  }
}
