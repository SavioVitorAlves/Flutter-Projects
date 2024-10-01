import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/cart_item_wedget.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/oder_list.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final itens = cart.itens.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 25
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(width: 10,),
                  Chip(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    label: Text(
                      'R\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ),
                  Spacer(),
                  CartBotton(cart: cart)
                ],
              ),
            )
          ),
          Expanded(
            child: ListView.builder(
              itemCount: itens.length,
              itemBuilder: (ctx, i)=> CartItemWedget(cartItem: itens[i],)
            )
          )
        ],
      ),
    );
  }
}

class CartBotton extends StatefulWidget {
  const CartBotton({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  State<CartBotton> createState() => _CartBottonState();
}

class _CartBottonState extends State<CartBotton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return _isLoading ? CircularProgressIndicator() : TextButton(
      onPressed: widget.cart.itensCount == 0 ? null : () async{
        setState(() => _isLoading = true);
        await Provider.of<OrderList>(context, listen: false).addOrder(widget.cart);
        
        widget.cart.clear();
        setState(() => _isLoading = false);
      }, 
      child: Text('COMPRAR'),
      style: TextButton.styleFrom(
        textStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary
        )
      ),
    );
  }
}