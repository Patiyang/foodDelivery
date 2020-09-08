import 'package:flutter/material.dart';
import 'package:foodDelivery/models/products.dart';
import 'package:foodDelivery/service/productsService.dart';

class ProductsProvider with ChangeNotifier {
  ProductsService _productsService = new ProductsService();
  List<ProductsModel> products = [];

  ProductsProvider.initialize() {
    loadProducts();
  }

  loadProducts() async {
    products = await _productsService.fetchProducts();
    notifyListeners();
  }
}
