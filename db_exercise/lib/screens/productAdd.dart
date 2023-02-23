import 'package:db_exercise/data/dbHelper.dart';
import 'package:db_exercise/models/product.dart';
import 'package:flutter/material.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({super.key});

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  DbHelper db = DbHelper();
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtPrice = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ÜRÜN EKLEME SAYFASI"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Flexible(
                child: SingleChildScrollView(child: buildProductAddForm())),
            buildSaveButton()
          ],
        ));
  }

  ElevatedButton buildSaveButton() => ElevatedButton(
      onPressed: () {
        addProduct();
      },
      child: Text("KAYDET"));

  Form buildProductAddForm() {
    return Form(
        child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildNameField(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildDescriptionField(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildPriceField(),
          ),
        ],
      ),
    ));
  }

  TextFormField buildNameField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Ürün Adı",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)))),
      keyboardType: TextInputType.text,
      controller: txtName,
    );
  }

  TextFormField buildDescriptionField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Ürün Açıklama",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)))),
      keyboardType: TextInputType.text,
      controller: txtDescription,
    );
  }

  TextFormField buildPriceField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Ürün Fiyatı",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)))),
      keyboardType: TextInputType.number,
      controller: txtPrice,
    );
  }

  void addProduct() async {
    var result = await db.createProduct(Product(
        txtName.text, txtDescription.text, double.parse(txtPrice.text)));
    Navigator.pop(context, true);
  }
}
