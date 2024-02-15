import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app_flutter/api/shop_api.dart';
import 'package:shop_app_flutter/models/shop_item.dart';
import 'package:shop_app_flutter/provider/cart_provider.dart';
import 'package:shop_app_flutter/screens/auth_screen.dart';
import 'package:shop_app_flutter/widgets/cart_button.dart';

class ShopScreen extends StatefulWidget {
  static const String routeName = '/shop';

  const ShopScreen({Key? key}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  void initState() {
    // Important: We Fetch shopItems only once!
    shopItems = ShopApi.getProducts();
    super.initState();
  }

  // This future will be used in Future builder, once value is populated!
  // Note: This must be a Future in order to use it in Future builder
  late Future<List<ShopItem>> shopItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop App'),
        actions: [
          const CartButton(),
          IconButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.clear();
              if (mounted) {
                Navigator.of(context)
                    .pushReplacementNamed(AuthScreen.routeName);
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: FutureBuilder<List<ShopItem>>(
        future: shopItems,
        builder:
            (BuildContext context, AsyncSnapshot<List<ShopItem>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(child: Text('Loading....'));
            default:
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                if (snapshot.hasData) {
                  return _getShopGridView(snapshot.data!);
                }
                return const Center(child: Text('No data...'));
              }
          }
        },
      ),
    );
  }

  Widget _getShopGridView(List<ShopItem> items) {
    return GridView.builder(
      padding: const EdgeInsets.all(12.0),
      // Provide length
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];

        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: GridTile(
            key: UniqueKey(),
            header: GridTileBar(
              backgroundColor: Colors.black.withOpacity(0.5),
              title: Text(item.title),
              subtitle: Text(item.subtitle),
            ),
            footer: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Add to provider like this:
                  Provider.of<CartProvider>(context, listen: false).add(item);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Add to cart',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            child: Image.network(item.imageUrl, fit: BoxFit.cover),
          ),
        );
      },
    );
  }
}
