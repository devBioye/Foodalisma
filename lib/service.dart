import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class FoodCollection{
  String name;
  double price;
  String url;
  String detail;
  String location;
  int add;
  bool isFav;
  Color favColor;
  FoodCollection({this.name, this.price, this.url, this.detail, this.location, this.add, this.isFav, this.favColor});
}

class CartDetail{
  static Future<void> createTable(Database database) async {
    await database.execute("CREATE TABLE cart_detail ("
        "id INTEGER PRIMARY KEY,"
        "name TEXT,"
        "url TEXT,"
        "price TEXT,"
        "number_of_meal TEXT"
        ")");
  }
  static Future<Database> db() async {
    return openDatabase('cart1.db', version: 1, onCreate: (Database database, int version) async {
      await createTable(database);
    });
  }
  static Future<int> createItem(int identity, String name, String url, String price, String numOfMeal) async {
    final db = await CartDetail.db();

    final data = {'id': identity, 'name': name, 'url': url, 'price' : price, 'number_of_meal' : numOfMeal};
    final id = await db.insert('cart_detail', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }
  Future <List<FoodCollection>> getFood() async {
    final db = await CartDetail.db();

    final List<Map<String, dynamic>> mapFood = await db.query('cart_detail');
    return List.generate(mapFood.length, (index) {
      return FoodCollection(name: mapFood[index]['name'], price: double.parse(mapFood[index]['price']), url: mapFood[index]['url'], add: int.parse(mapFood[index]['number_of_meal']));
    });
  }
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await CartDetail.db();
    return db.query('cart_detail', where: "id = ?", whereArgs: [id], limit: 1);
  }
  static Future<int> updateMealNo(String name, String numOfMeal) async {
    final db = await CartDetail.db();

    final data = {
      'number_of_meal': numOfMeal,
    };

    final result =
    await db.update('cart_detail', data, where: "name = ?", whereArgs: [name]);
    return result;
  }
  static Future<void> deleteItem(String name) async {
    final db = await CartDetail.db();
    try {
      await db.delete("cart_detail", where: "name = ?", whereArgs: [name]);
      print('done');
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

}

