import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'cart_model.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    debugPrint('Initializing database...');
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'cart.db');
    debugPrint('Database path: $path');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE cart (id INTEGER PRIMARY KEY , productId VARCHAR UNIQUE,productName TEXT,initialPrice DOUBLE, productPrice DOUBLE , quantity INTEGER, unitTag TEXT , image TEXT )',
    );
  }

  Future<Cart> insert(Cart cart) async {
    var dbClient = await db;

    List<Map<String, dynamic>> existing = await dbClient!.query(
      'cart',
      where: 'productId = ?',
      whereArgs: [cart.productId],
    );

    if (existing.isNotEmpty) {
      int currentQty = existing.first['quantity'] as int;
      double initialPrice = existing.first['initialPrice'] as double;

      await dbClient.update(
        'cart',
        {
          'quantity': currentQty + 1,
          'productPrice': initialPrice * (currentQty + 1),
        },
        where: 'productId = ?',
        whereArgs: [cart.productId],
      );

      return Cart(
        id: existing.first['id'] as int,
        productId: cart.productId,
        productName: cart.productName,
        initialPrice: cart.initialPrice,
        productPrice: initialPrice * (currentQty + 1),
        quantity: currentQty + 1,
        unitTag: cart.unitTag,
        image: cart.image,
      );
    } else {
      int id = await dbClient.insert('cart', cart.toMap()..remove('id'));
      return Cart(
        id: id,
        productId: cart.productId,
        productName: cart.productName,
        initialPrice: cart.initialPrice,
        productPrice: cart.productPrice,
        quantity: cart.quantity,
        unitTag: cart.unitTag,
        image: cart.image,
      );
    }
  }

  Future<List<Cart>> getCartList() async {
    try {
      var dbClient = await db;
      if (dbClient == null) throw Exception('Database not initialized');
      final queryRes = await dbClient.query('cart');
      return queryRes.map((e) => Cart.fromMap(e)).toList();
    } catch (e) {
      debugPrint('Error fetching cart: $e');
      return [];
    }
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateQuantity(int id, int newQuantity, double newPrice) async {
    var dbClient = await db;
    return await dbClient!.update(
      'cart',
      {'quantity': newQuantity, 'productPrice': newPrice},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
