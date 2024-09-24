import 'package:flutter/material.dart';
import 'package:shop/models/products.dart';

class ProductDetailPage extends StatelessWidget {
  
  
  const ProductDetailPage({ super.key});

  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(product.imageUrl, fit: BoxFit.cover,),
            ),
            SizedBox(height: 10,),
            Text(
              'R\$ ${product.price}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 20
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                product.description,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
