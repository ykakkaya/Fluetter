import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal.shade300,
          title: Text(
            "RECAP-1",
            style: TextStyle(
                fontSize: 20, fontStyle: FontStyle.italic, wordSpacing: 2),
          ),
        ),
        body: rowElements(),
      ),
    );
  }

  Widget columnElements() {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Flexible(
          child: Container(
            width: 75,
            height: 90,
            color: Colors.amber.shade50,
            margin: EdgeInsets.all(1),
            child: Center(
                child: Text(
              "D",
              style: TextStyle(fontSize: 16),
            )),
          ),
        ),
        Flexible(
          child: Container(
            width: 75,
            height: 90,
            color: Colors.amber.shade100,
            margin: EdgeInsets.all(1),
            child: Center(
                child: Text(
              "E",
              style: TextStyle(fontSize: 16),
            )),
          ),
        ),
        Flexible(
          child: Container(
            width: 75,
            height: 90,
            color: Colors.amber.shade200,
            margin: EdgeInsets.all(1),
            child: Center(
                child: Text(
              "R",
              style: TextStyle(fontSize: 16),
            )),
          ),
        ),
        Flexible(
          child: Container(
            width: 75,
            height: 90,
            color: Colors.amber.shade300,
            margin: EdgeInsets.all(1),
            child: Center(
                child: Text(
              "S",
              style: TextStyle(fontSize: 16),
            )),
          ),
        ),
        Flexible(
          child: Container(
            width: 75,
            height: 90,
            color: Colors.amber.shade400,
            margin: EdgeInsets.all(1),
            child: Center(
                child: Text(
              "L",
              style: TextStyle(fontSize: 16),
            )),
          ),
        ),
        Flexible(
          child: Container(
            width: 75,
            height: 90,
            color: Colors.amber.shade500,
            margin: EdgeInsets.all(1),
            child: Center(
                child: Text(
              "E",
              style: TextStyle(fontSize: 16),
            )),
          ),
        ),
        Flexible(
          child: Container(
            width: 75,
            height: 90,
            color: Colors.amber.shade600,
            margin: EdgeInsets.all(1),
            child: Center(
                child: Text(
              "R",
              style: TextStyle(fontSize: 16),
            )),
          ),
        ),
        Flexible(
          child: Container(
            width: 75,
            height: 90,
            color: Colors.amber.shade700,
            margin: EdgeInsets.all(1),
            child: Center(
                child: Text(
              "İ",
              style: TextStyle(fontSize: 16),
            )),
          ),
        )
      ]),
    );
  }

  Widget rowElements() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        columnElements(),
        Flexible(
          child: Container(
            width: 75,
            height: 90,
            color: Colors.amber.shade100,
            margin: EdgeInsets.all(1),
            child: Center(
                child: Text(
              "A",
              style: TextStyle(fontSize: 16),
            )),
          ),
        ),
        Flexible(
          child: Container(
            width: 75,
            height: 90,
            color: Colors.amber.shade200,
            margin: EdgeInsets.all(1),
            child: Center(
                child: Text(
              "R",
              style: TextStyle(fontSize: 16),
            )),
          ),
        ),
        Flexible(
          child: Container(
            width: 75,
            height: 90,
            color: Colors.amber.shade300,
            margin: EdgeInsets.all(1),
            child: Center(
                child: Text(
              "T",
              style: TextStyle(fontSize: 16),
            )),
          ),
        ),
      ],
    );
  }
}
