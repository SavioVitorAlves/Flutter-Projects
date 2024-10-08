import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/badgee.dart';
import 'package:shop/components/product_grid.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';

enum FilterOptions{
  Favorite,
  All
}


class ProductOverivewPage extends StatefulWidget {
  
  ProductOverivewPage({super.key});

  @override
  State<ProductOverivewPage> createState() => _ProductOverivewPageState();
}

class _ProductOverivewPageState extends State<ProductOverivewPage> {
  bool _showFavoriteOnly = false;
  bool _isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProductList>(context, listen: false).loadProducts()
    .then((value) => setState(() => _isLoading = false ));
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Milha Loja!',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert, color: Colors.white,),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Somente Favoritos'),
                value: FilterOptions.Favorite,
              ),
              PopupMenuItem(
                child: Text('Todos'),
                value: FilterOptions.All,
              )
            ],
            onSelected: (FilterOptions selectedValue){
              setState(() {
                if (selectedValue == FilterOptions.Favorite) {
                  _showFavoriteOnly = true;
                }else{
                  _showFavoriteOnly = false;
                }  
              }); 
            },
          ),
          Consumer<Cart>(
            child: IconButton(
                onPressed: (){
                  Navigator.of(context).pushNamed(AppRoutes.CART);
                }, 
                icon: const Icon(Icons.shopping_cart, color: Colors.white,)
            ),
            builder: (ctx, cart, child) => Badgee(
              value: cart.itensCount.toString(),
              child: child!,
            ),
          )
        ],
      ),
      body: _isLoading 
      ? Center(child: CircularProgressIndicator()) 
      : ProductGrid(_showFavoriteOnly),
      
      drawer: AppDrawer(),
    );
  }
}

