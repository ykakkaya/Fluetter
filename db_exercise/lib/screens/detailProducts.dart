import 'package:db_exercise/data/dbHelper.dart';
import 'package:db_exercise/models/product.dart';
import 'package:db_exercise/screens/getProduct.dart';
import 'package:db_exercise/screens/updateProduct.dart';
import 'package:flutter/material.dart';

class DetailProducts extends StatefulWidget {
  Product selectedProduct;
  DetailProducts(this.selectedProduct, {super.key});

  @override
  State<DetailProducts> createState() => _DetailProductsState();
}

class _DetailProductsState extends State<DetailProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("ÜRÜN DETAYLARI")),
        body: Column(
          children: [
            Flexible(
                child: Form(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(children: [
                  detailId(),
                  detailName(),
                  detailDescription(),
                  detailPrice()
                ]),
              ),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UpdateProduct(widget.selectedProduct)));
                    },
                    child: Text("GÜNCELLE")),
                ElevatedButton(
                    onPressed: () async {
                      DbHelper db = DbHelper();
                      await db.deleteProduct(
                          int.parse(widget.selectedProduct.id.toString()));
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (contex) => GetProducts()));
                    },
                    child: Text("SİL"))
              ],
            )
          ],
        ));
  }

  TextFormField detailPrice() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      initialValue: widget.selectedProduct.price.toString(),
    );
  }

  TextFormField detailDescription() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      initialValue: widget.selectedProduct.description,
    );
  }

  TextFormField detailName() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      initialValue: widget.selectedProduct.name,
    );
  }

  TextFormField detailId() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      initialValue: widget.selectedProduct.id.toString(),
    );
  }
}
