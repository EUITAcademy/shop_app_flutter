import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/provider/cart_provider.dart';
import 'package:shop_app_flutter/screens/cart_screen.dart';

class CartButton extends StatelessWidget {
  const CartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      // Child is used for widgets that won't rebuild when provider changes
      builder: (context, cart, child) {
        return ElevatedButton(
          child: Text(
              'Cart${cart.items.isEmpty ? '' : '(${cart.items.length})'}'),
          onPressed: () {
            Navigator.of(context).pushNamed(CartScreen.routeName);
          },
        );
      },
    );
  }
}
