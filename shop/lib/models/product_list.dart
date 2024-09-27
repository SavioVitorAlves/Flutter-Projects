import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/products.dart';

class ProductList with ChangeNotifier{
  List<Product> _itens= dummyProducts;
  
  List<Product> get itens =>[..._itens];
  List<Product> get FavoriteItens => _itens.where((prod) => prod.isFavorite).toList();

  int get itensCount{
    return _itens.length;
  }

  void saveProduct(Map<String, Object> data){
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(), 
      name: data['name'] as String, 
      description: data['description'] as String, 
      price: data['price'] as double, 
      imageUrl: data['imageUrl'] as String
    );
    if (hasId) {
      updateProduct(product);
    }else{
      addProduct(product);
    }
    
  }

  void addProduct(Product product){
    _itens.add(product);
    notifyListeners();
  }

  void updateProduct(Product product){
    int index = _itens.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _itens[index] = product;
      notifyListeners();
    }
  }

  void removeProduct(Product product){
    int index = _itens.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
       _itens.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }
}

/*bool _showFavoriteOnly = false;
  List<Product> get itens {
    if (_showFavoriteOnly) {
      return _itens.where((prod) => prod.isFavorite).toList();
    }
    return [..._itens];
  }

  void showFavoriteOnly(){
    _showFavoriteOnly = true;
    notifyListeners();
  }
  void showAll(){
    _showFavoriteOnly = false;
    notifyListeners();
  }*/