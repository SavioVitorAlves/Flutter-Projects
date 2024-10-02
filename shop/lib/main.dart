import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/oder_list.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/screens/auth_page.dart';
import 'package:shop/screens/cart_page.dart';
import 'package:shop/screens/orders_page.dart';
import 'package:shop/screens/product_detail_page.dart';
import 'package:shop/screens/product_form_page.dart';
import 'package:shop/screens/product_overivew_page.dart';
import 'package:shop/screens/product_page.dart';
import 'package:shop/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Auth(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed( 
            seedColor: Colors.purple, 
            secondary: Colors.deepOrange
          ),
          fontFamily: 'Lado',
          useMaterial3: true,
        ),
        //home: ProductOverivewPage(),
        routes: {
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailPage(),
          AppRoutes.CART: (ctx) => CartPage(),
          AppRoutes.HOME: (ctx) => ProductOverivewPage(),
          AppRoutes.AUTH: (ctx) => AuthPage(),
          AppRoutes.ORDERS: (ctx) => OrdersPage(),
          AppRoutes.PRODUCTS: (ctx) => ProductPage(),
          AppRoutes.PRODUCTS_FORM: (ctx) => ProductFormPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

