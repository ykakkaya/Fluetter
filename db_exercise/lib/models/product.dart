class Product {
  int? id;
  String name = "";
  String description = "";
  double price = 0;

  Product.withId(this.id, this.name, this.description, this.price);
  Product(String name, String description, double price) {
    this.name = name;
    this.description = description;
    this.price = price;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["name"] = this.name;
    map["description"] = this.description;
    map["price"] = this.price;
    if (this.id != null) {
      map["id"] = this.id;
    }
    return map;
  }

  Product.toObject(dynamic o) {
    this.id = int.parse(o["id"].toString());
    this.name = o["name"];
    this.description = o["description"];
    this.price = double.parse(o["price"].toString())!;
  }
}
