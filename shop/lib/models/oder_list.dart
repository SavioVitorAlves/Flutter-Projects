import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shop/models/cart.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/order.dart';
import 'package:shop/utils/constants.dart';

class OrderList with ChangeNotifier {
  List<Order> _itens = [];

  List<Order> get itens{
    return [..._itens];
  }
  
  int get itensCount{
    return _itens.length;
  }
  Future<void> loadOrders() async {
    _itens.clear();
    final response = await http.get(Uri.parse('${Constants.ORDER_BASE_URL}.json'));
    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((orderId, orderData){
      _itens.add(
        Order(
          id: orderId, 
          date: DateTime.parse(orderData['date']),
          total: orderData['total'],
          products: (orderData['products'] as List<dynamic>).map((item){
            return CartItem(
              id: item['id'], 
              productId: item['productId'], 
              name: item['name'], 
              quantity: item['quantity'], 
              price: item['price']
            );
            
          }).toList(), 
      ));
    });
    notifyListeners();
  }

  Future<void> addOrder(Cart cart) async{
    final date = DateTime.now();
    final response = await http.post(
      Uri.parse('${Constants.ORDER_BASE_URL}.json'),
      body: jsonEncode(
        {
           'total': cart.totalAmount,
           'date': date.toIso8601String(),
           'products': cart.itens.values.map((cartItem) => {
            'id':cartItem.id,
            'productId':cartItem.productId,
            'name':cartItem.name,
            'quantity':cartItem.quantity,
            'price':cartItem.price,
           }).toList(),
        },
      ),
    );
    final id = jsonDecode(response.body)['name'];
    _itens.insert(
      0, 
      Order(
        id: id, 
        total: cart.totalAmount, 
        products: cart.itens.values.toList( ), 
        date: date
      )
    );
    notifyListeners();
  }
}