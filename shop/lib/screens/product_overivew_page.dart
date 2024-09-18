import 'package:flutter/material.dart';
import 'package:shop/components/product_grid.dart';


class ProductOverivewPage extends StatelessWidget {
  
  ProductOverivewPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Milha Loja!'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
      ),
      body: ProductGrid(),
    );
  }
}

