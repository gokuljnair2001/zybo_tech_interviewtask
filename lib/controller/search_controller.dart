import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProductSearchController extends BaseViewModel {
  List<Product> searchList = [];
  List<Product> originalList = []; 
  bool isLoading = false;

  ProductSearchController() {
    
    originalList = [
      Product(name: 'Product 1', price: 100, isActive: true),
      Product(name: 'Product 2', price: 200, isActive: false),
    ];
    searchList = originalList;
  }

  void search({required String keyword, required BuildContext context}) async {
    if (keyword.isEmpty) {
      searchList = originalList;
      notifyListeners();
      return;
    }

    
    isLoading = true;
    notifyListeners();

    
    await Future.delayed(const Duration(seconds: 1));

    
    searchList = originalList
        .where((product) =>
            product.name!.toLowerCase().contains(keyword.toLowerCase()))
        .toList();

    
    isLoading = false;
    notifyListeners();
  }
}

class Product {
  final String? name;
  final int price;
  final bool? isActive;

  Product({this.name, required this.price, this.isActive});
}
