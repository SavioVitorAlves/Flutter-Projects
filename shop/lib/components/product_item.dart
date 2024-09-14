import 'package:flutter/material.dart';
import 'package:shop/models/products.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  
  const ProductItem({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.favorite),
            color: Theme.of(context).colorScheme.secondary,
          ),
          title: Text(
            product.title, 
            textAlign: TextAlign.center,),
          trailing: IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.shopping_cart ),
            color: Theme.of(context).colorScheme.secondary,
            ),
        ),
      ),
    );
  }
}