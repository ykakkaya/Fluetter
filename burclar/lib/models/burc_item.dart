import 'package:burclar/burcDetay.dart';
import 'package:flutter/material.dart';

import 'burc.dart';

class BurcItem extends StatelessWidget {
  final Burc listelenenBurc;
  const BurcItem({required this.listelenenBurc, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
          child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BurcDetay(secilenBurc: listelenenBurc)));
        },
        leading: CircleAvatar(
            child: Image(
                image: AssetImage(
                    "lib/images/" + listelenenBurc.getBurcImgKucuk))),
        title: Text(
          listelenenBurc.getBurcAdi,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        subtitle: (Text(
          listelenenBurc.getBurcTarihi,
          style: Theme.of(context).textTheme.bodyMedium,
        )),
        trailing: Icon(
          Icons.arrow_forward_ios_outlined,
          color: Theme.of(context).primaryColorDark,
        ),
      )),
    );
  }
}
