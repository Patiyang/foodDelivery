import 'package:flutter/material.dart';
import 'package:foodDelivery/models/shops.dart';
import 'package:foodDelivery/service/shopService.dart';

class ShopProvider with ChangeNotifier {
  ShopService _shopService = new ShopService();
  List<ShopModel> shops = [];
  List<ShopModel> shopsSearched = [];

  ShopProvider.initialize() {
    loadShops();
  }

  loadShops() async {
    shops = await _shopService.fetchProducts();
    notifyListeners();
  }
}
