import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'models/burc.dart';

class BurcDetay extends StatefulWidget {
  final Burc secilenBurc;
  const BurcDetay({required this.secilenBurc, super.key});

  @override
  State<BurcDetay> createState() => _BurcDetayState();
}

class _BurcDetayState extends State<BurcDetay> {
  Color appBarColor = Colors.transparent;
  late PaletteGenerator _generator;
  @override
  void initState() {
    appBarColorFind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: appBarColor,
          expandedHeight: 250,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
              title:
                  Text(widget.secilenBurc.getBurcAdi + " Burcunun Özellikleri"),
              centerTitle: true,
              background: Image.asset(
                'lib/images/' + widget.secilenBurc.getBurcImgBuyuk,
                fit: BoxFit.cover,
              )),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    widget.secilenBurc.getBurcTarihi,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.secilenBurc.getBurcDetay,
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }

  void appBarColorFind() async {
    _generator = await PaletteGenerator.fromImageProvider(
        AssetImage("lib/images/" + widget.secilenBurc.getBurcImgBuyuk));

    setState(() {
      appBarColor = _generator.dominantColor!.color;
    });
  }
}
