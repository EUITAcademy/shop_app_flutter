import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app_flutter/models/shop_item.dart';

class CartProvider extends ChangeNotifier {
  // initializer
  CartProvider() {
    _getItemsFromDatabase();
  }

  // Internal, private state of the cart.
  List<ShopItem> _items = List<ShopItem>.empty(growable: true);

  // Getter, can not be changed from outside!
  List<ShopItem> get items => _items;

  // Adds ShopItem to cart.
  void add(ShopItem item) {
    _items.add(item);
    // This call tells the widgets that are listening
    // to this Provider to rebuild.
    notifyListeners();

    // Write data to database
    _writeItemsToDataBase(_items);
  }

  void removeOne(ShopItem item) {
    final index = _items.indexWhere((element) => element.id == item.id);
    _items.removeAt(index);
    // This call tells the widgets that are listening
    // to this Provider to rebuild.
    notifyListeners();

    // Write data to database
    _writeItemsToDataBase(_items);
  }

  void removeAll() {
    _items.clear();
    // This call tells the widgets that are listening
    // to this Provider to rebuild.
    notifyListeners();

    // Remove all items
    _removeAll();
  }

  Future<void> _writeItemsToDataBase(List<ShopItem> items) async {
    // Write data to database
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonMap = jsonEncode(items);
    prefs.setString('items', jsonMap);
  }

  Future<void> _removeAll() async {
    // Write data to database
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('items');
  }

  Future<void> _getItemsFromDatabase() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('items');

    if (json != null) {
      final data = jsonDecode(json) as List<dynamic>;
      final items = List<ShopItem>.from(
        data.map(
          (model) => ShopItem.fromJson(model),
        ),
      );
      _items = items;
      notifyListeners();
    }
  }
}
