import 'package:flutter/material.dart';
import 'package:shop_app_flutter/screens/auth_screen.dart';
import 'package:shop_app_flutter/screens/cart_screen.dart';
import 'package:shop_app_flutter/screens/shop_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AuthScreen(),
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == AuthScreen.routeName) {
          return MaterialPageRoute(
            builder: (_) => const AuthScreen(),
          );
        }
        if (settings.name == ShopScreen.routeName) {
          return MaterialPageRoute(
            builder: (_) => const ShopScreen(),
          );
        }
        if (settings.name == CartScreen.routeName) {
          // We can hide argument with _ if we don't need it
          return MaterialPageRoute(
            builder: (_) => const CartScreen(),
          );
        }
        // implement onUnknown route to handle unknown routes
        return null;
      },
    );
  }
}
