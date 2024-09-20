import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order.dart';

class OrderList with ChangeNotifier {
  List<Order> _itens = [];

  List<Order> get itens{
    return [..._itens];
  }
  
  int get itensCount{
    return _itens.length;
  }

  void addOrder(Cart cart){
    _itens.insert(
      0, 
      Order(
        id: Random().nextDouble().toString(), 
        total: cart.totalAmount, 
        products: cart.itens.values.toList( ), 
        date: DateTime.now()
      )
    );
    notifyListeners();
  }
}