import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/products.dart';

class ProductList with ChangeNotifier{
  List<Product> _itens= dummyProducts;
  
  List<Product> get itens =>[..._itens];
  List<Product> get FavoriteItens => _itens.where((prod) => prod.isFavorite).toList();


  void addProduct(Product product){
    _itens.add(product);
    notifyListeners();
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