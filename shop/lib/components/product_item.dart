import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/models/products.dart';
import 'package:shop/utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({
    required this.product,
    super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.name),
      trailing: Container(
        width: 80,
        child: Row(
          children: [
            IconButton(
              onPressed: (){
                Navigator.of(context).pushNamed(AppRoutes.PRODUCTS_FORM, arguments: product);
              }, 
              icon: const Icon(Icons.edit),
              color: Theme.of(context).colorScheme.primary,
            ),
            IconButton(
              onPressed: (){
                showDialog(
                  context: context, 
                  builder: (ctx)  => AlertDialog(
                    title: Text('Excluir Produto'),
                    content: Text('Tem Certeza?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(), 
                        child: Text('Não')
                      ),
                      TextButton(
                        onPressed: () {
                          Provider.of<ProductList>(context, listen: false).removeProduct(product);
                          Navigator.of(context).pop();
                        }, 
                        child: Text('Sim')
                      )
                    ],
                  )
                );
              }, 
              icon: const Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error
            )
          ],
        )
      ),
    );
  }
}