import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/products.dart';
import 'package:shop/utils/app_routes.dart';

class ProductGridItem extends StatelessWidget {

  
  const ProductGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    final cart = Provider.of<Cart>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              onPressed: (){
                product.toggleFavorite(auth.token ?? '', auth.userId ?? '');
              }, 
              icon:  Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          title: Text(
            product.name, 
            textAlign: TextAlign.center,),
          trailing: IconButton(
            onPressed: (){
              cart.addItem(product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Produto adicionado ao carrinho!'),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'DESFAZER', 
                    onPressed: (){
                      cart.removeSingleItem(product.id);
                    }
                  ), 
                )
              );
            }, 
            icon: const Icon(Icons.shopping_cart ),
            color: Theme.of(context).colorScheme.secondary,
            ),
        ),
        child: GestureDetector(
          child: Hero(
            tag: product.id,
            child: FadeInImage(
              placeholder: AssetImage('assets/images/product-placeholder.png'), 
              image: NetworkImage(product.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          /*child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),*/
          onTap: (){
            Navigator.of(context).pushNamed(
             AppRoutes.PRODUCT_DETAIL,
             arguments: product,
            );
          },
        ),
      ),
    );
  }
}