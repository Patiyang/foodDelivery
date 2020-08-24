import 'package:flutter/material.dart';
import 'package:foodDelivery/models/products.dart';
import 'package:foodDelivery/service/productsService.dart';

class ProductsProvider with ChangeNotifier {
  ProductsService _productsService = new ProductsService();
  List<ProductsModel> products = [];
  List<ProductsModel> productsSearched = [];

  ProductsProvider.initialize() {
    loadClothes();
  }

  loadClothes() async {
    products = await _productsService.fetchProducts();
    notifyListeners();
  }
}
