import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recap2/MyCounter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "FLUETTER EXERCİSE",
      theme: ThemeData(primarySwatch: Colors.cyan),
      home: const MyCounter(),
    );
  }
}
