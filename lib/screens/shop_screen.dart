import 'package:flutter/material.dart';
import 'package:shop_app_flutter/models/shop_item.dart';
import 'package:shop_app_flutter/screens/auth_screen.dart';
import 'package:shop_app_flutter/widgets/cart_button.dart';

class ShopScreen extends StatefulWidget {
  // Route name for this screen.
  // Static properties are attributes that belong to a class, rather than to an instance of that class.
  // Can be accessed with ShopScreen.routeName
  static const String routeName = '/shop';

  const ShopScreen({Key? key}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  void initState() {
    // Todo: Fetch shop items at start
    super.initState();
  }

  final List<ShopItem> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop App'),
        actions: [
          const CartButton(),
          IconButton(
            onPressed: () async {
              // Replaces Page in Stack
              Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(),
    );
  }

}
