import 'dart:async';

import 'package:db_exercise/models/product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  Database? _db;

  Future<Database> get db async {
    if (_db == null) {
      return initializeDb();
    } else {
      return _db!;
    }
  }

  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), "etrade.db");
    var eTradeDb = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return eTradeDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE products (id INTEGER PRIMARY KEY, name TEXT, description TEXT, price REAL)');
  }

  Future<List<Product>> getAllProducts() async {
    Database db = await this.db;
    var result = await db.query("products");
    return List.generate(
        result.length, (index) => Product.toObject(result[index]));
  }

  Future<int> createProduct(Product product) async {
    Database db = await this.db;
    var result = await db.insert("products", product.toMap());
    return result;
  }

  Future<int> deleteProduct(int id) async {
    Database db = await this.db;
    var result = await db.delete("products", where: "id=?", whereArgs: [id]);
    return result;
  }

  Future<int> updateProduct(Product product) async {
    Database db = await this.db;
    var result = await db.update("products", product.toMap(),
        where: "id=?", whereArgs: [product.id]);
    return result;
  }
}
