import 'package:db_exercise/data/dbHelper.dart';
import 'package:db_exercise/screens/productAdd.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../models/product.dart';
import 'detailProducts.dart';
import 'updateProduct.dart';

class GetProducts extends StatefulWidget {
  const GetProducts({super.key});

  @override
  State<GetProducts> createState() => _GetProductsState();
}

class _GetProductsState extends State<GetProducts> {
  List<Product> productList = [];
  var db = DbHelper();
  @override
  void initState() {
    setState(() {
      getProducts();
    });
  }

  void getProducts() async {
    setState(() {
      var result = db.getAllProducts();
      result.then((data) => this.productList = data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ÜRÜN LİSTESİ"),
        centerTitle: true,
      ),
      body: builProductList(),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn1",
        child: Icon(Icons.add),
        onPressed: () => {goToProductAdd(context)},
      ),
    );
  }

  ListView builProductList() {
    return ListView.builder(
      itemCount: productList.length,
      itemBuilder: (context, index) {
        var selectedProduct = productList[index];
        return Card(
          child: ListTile(
            leading: Text(productList[index].id.toString()),
            title: Text(productList[index].name),
            trailing: Text(productList[index].price.toString()),
            onLongPress: () {
              goToUpdateProduct(context, selectedProduct);
            },
            onTap: () {
              // db.deleteProduct(int.parse(productList[index].id.toString()));
              goToDetailProduct(context, selectedProduct);
            },
          ),
        );
      },
    );
  }

  void goToUpdateProduct(BuildContext context, Product p) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => UpdateProduct(p)));
  }

  goToProductAdd(BuildContext context) async {
    bool result =
        await Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
      return ProductAdd();
    })));

    setState(() {
      if (result != null) {
        if (result) {
          getProducts();
        }
      }
    });
  }

  void goToDetailProduct(BuildContext context, Product p) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => DetailProducts(p)));
  }
}
