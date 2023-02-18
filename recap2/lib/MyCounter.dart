import 'package:flutter/material.dart';

class MyCounter extends StatefulWidget {
  const MyCounter({super.key});

  @override
  State<MyCounter> createState() => _MyCounterState();
}

class _MyCounterState extends State<MyCounter> {
  int _sayac = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          "RECAP-2(COUNTER)",
          style: TextStyle(fontSize: 24),
        )),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [myTextWidget(), mySayacWidget(sayac: _sayac)],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
                onPressed: () {
                  sayaciArtir();
                },
                child: Icon(Icons.add)),
            FloatingActionButton(
              onPressed: () {
                sifirla();
              },
              child: Icon(
                Icons.exposure_zero,
              ),
              backgroundColor: Colors.red,
            ),
            FloatingActionButton(
              onPressed: () {
                sayaciAzalt();
              },
              child: Icon(Icons.exposure_minus_1),
              backgroundColor: Colors.amber,
            )
          ],
        ));
  }

  void sayaciArtir() {
    setState(() {});
    _sayac++;
  }

  void sayaciAzalt() {
    setState(() {
      _sayac--;
    });
  }

  void sifirla() {
    setState(() {
      _sayac = 0;
    });
  }
}

class mySayacWidget extends StatelessWidget {
  const mySayacWidget({
    super.key,
    required int sayac,
  }) : _sayac = sayac;

  final int _sayac;

  @override
  Widget build(BuildContext context) {
    return Text(
      _sayac.toString(),
      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
    );
  }
}

class myTextWidget extends StatelessWidget {
  const myTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "SAYAÇ KAÇI GÖSTERİYOR",
      style: TextStyle(fontSize: 24),
    );
  }
}
