import 'package:flutter/material.dart';
import 'package:shop_app_flutter/models/shop_item.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      // Builder provides us with convenient builder function,
      // We can calculate some logic before returning Widget
      body: Builder(
        builder: (context) {

          // Todo: Get from provider
          final List<ShopItem> items = [];

          // unique list of items (we will show only 1 item of a kind in a list)
          // Set is a collection of unique items, this will remove duplicates
          // when we convert it back to list with .toList()
          final uniqueList = List<ShopItem>.from(items).toSet().toList();

          if (items.isEmpty) {
            return const Center(child: Text('Cart empty...'));
          }

          return ListView(
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
            children: [
              // build items with ...separator
              // insert list inside other list
              ...uniqueList.map(
                (e) => _getItemListTile(
                  item: e,
                  allItems: items,
                  context: context,
                ),
              ),

              const SizedBox(height: 8),
              // This widget won't rebuild (in our case button)
              ElevatedButton(
                onPressed: () async {
                  // Todo: Implement Order here
                },
                child: const Text('Order'),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _getItemListTile({
    required ShopItem item,
    required List<ShopItem> allItems,
    required BuildContext context,
  }) {
    // Calculate total price for each object
    final sameItemCount = allItems.where((e) => e.id == item.id).length;
    final totalPrice = item.price * sameItemCount;

    return Row(
      children: [
        Text('${item.title}${sameItemCount != 0 ? '($sameItemCount)' : ''}'),
        const SizedBox(width: 4),
        // with \ we can say that it's a raw character,
        // meaning we can output it even if it is a special character in String
        Text('$totalPrice\$'),
        const Spacer(),
        TextButton(
          child: const Text('Remove'),
          onPressed: () {
            // Todo: Implement remove from cart
          },
        ),
      ],
    );
  }
}
