import 'package:db_exercise/data/dbHelper.dart';
import 'package:db_exercise/models/product.dart';
import 'package:db_exercise/screens/getProduct.dart';
import 'package:flutter/material.dart';

class UpdateProduct extends StatefulWidget {
  DbHelper db = DbHelper();
  Product selectedProduct;
  UpdateProduct(this.selectedProduct, {super.key});

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtPrice = TextEditingController();
  @override
  void initState() {
    txtName.text = widget.selectedProduct.name.toString();
    txtDescription.text = widget.selectedProduct.description.toString();
    txtPrice.text = widget.selectedProduct.price.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ÜRÜN GÜNCELLEME SAYFASI"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Flexible(
              child: SingleChildScrollView(
            child: Form(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildTextFormName(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildTextFormDescription(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildTextFormPrice(),
                  )
                ],
              ),
            )),
          )),
          ElevatedButton(
              onPressed: () async {
                print("id" + widget.selectedProduct.id.toString());
                print("ad " + txtName.text);
                print("desc " + txtDescription.text);
                print("price " + txtPrice.text);
                await widget.db.updateProduct(Product.withId(
                    widget.selectedProduct.id,
                    txtName.text,
                    txtDescription.text,
                    double.tryParse(txtPrice.text)!));
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => GetProducts()));
              },
              child: Text("GÜNCELLE"))
        ],
      ),
    );
  }

  TextFormField buildTextFormName() {
    return TextFormField(
        controller: txtName,
        decoration: InputDecoration(
            labelText: "ÜRÜN ADI",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)))));
  }

  TextFormField buildTextFormDescription() {
    return TextFormField(
        controller: txtDescription,
        decoration: InputDecoration(
            labelText: "ÜRÜN AÇIKLAMA",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)))));
  }

  TextFormField buildTextFormPrice() {
    return TextFormField(
        controller: txtPrice,
        decoration: InputDecoration(
            labelText: "ÜRÜN FİYAT",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)))));
  }
}
