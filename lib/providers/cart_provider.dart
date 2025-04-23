import 'package:flutter/material.dart';
import 'package:magikart_grocery_app/db/cart_model.dart';
import 'package:magikart_grocery_app/db/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  DBHelper db = DBHelper();

  int _counter = 0;
  double _totalPrice = 0.0;
  List<Cart> _cartItems = [];

  int get counter => _counter;
  double get totalPrice => _totalPrice;
  List<Cart> get cartItems => _cartItems;

  Future<List<Cart>> getData() async {
    _cartItems = await db.getCartList();

    return _cartItems;
  }

  Future<void> refreshCart() async {
    _cartItems = await db.getCartList();
    notifyListeners();
  }

  void _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_item', _counter);
    prefs.setDouble('total_price', _totalPrice);
    notifyListeners();
  }

  void remCounterByAmount(int amount) {
    _counter -= amount;
    if (_counter < 0) _counter = 0;
    _setPrefItems();
    notifyListeners();
  }

  void _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_item') ?? 0;
    _totalPrice = prefs.getDouble('total_price') ?? 0.0;
    notifyListeners();
  }

  void addCounter() {
    _counter++;
    _setPrefItems();
    notifyListeners();
  }

  void remCounter() {
    _counter--;
    _setPrefItems();
    notifyListeners();
  }

  int getCounter() {
    _getPrefItems();
    return _counter;
  }

  void addTotalPrice(double productPrice) {
    _totalPrice = _totalPrice + productPrice;
    _setPrefItems();
    notifyListeners();
  }

  void remTotalPrice(double productPrice) {
    _totalPrice = _totalPrice - productPrice;
    _setPrefItems();
    notifyListeners();
  }

  double getTotalPrice() {
    _getPrefItems();
    return _totalPrice;
  }
}
