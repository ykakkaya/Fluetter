import 'package:burclar/models/burc.dart';
import 'package:burclar/models/burc_item.dart';
import 'package:flutter/material.dart';

import 'data/strings.dart';

class BurcListesi extends StatelessWidget {
  late List<Burc> tumBurclar;
  BurcListesi() {
    tumBurclar = veriKaynaginiHazirla();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BURÇLAR"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: tumBurclar.length,
                itemBuilder: (BuildContext context, int index) {
                  return BurcItem(listelenenBurc: tumBurclar[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Burc> veriKaynaginiHazirla() {
    List<Burc> gecici = [];
    for (int i = 0; i < 12; i++) {
      String imgKucuk = Strings.BURC_ADLARI[i].toLowerCase();
      imgKucuk = imgKucuk + "${i + 1}.png";
      String imgBuyuk = Strings.BURC_ADLARI[i].toLowerCase();
      imgBuyuk = imgBuyuk + "_buyuk${i + 1}.png";
      var eklenen = Burc(Strings.BURC_ADLARI[i], Strings.BURC_TARIHLERI[i],
          Strings.BURC_GENEL_OZELLIKLERI[i], imgKucuk, imgBuyuk);
      gecici.add(eklenen);
    }
    return gecici;
  }
}
