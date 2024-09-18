import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/products.dart';

class ProductList with ChangeNotifier{
  List<Product> _itens= dummyProducts;
  List<Product> get itens => [... _itens];

  void addProduct(Product product){
    _itens.add(product);
    notifyListeners();
  }
}