import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/screens/auth_screen.dart';
import 'package:shop_app_flutter/screens/cart_screen.dart';
import 'package:shop_app_flutter/screens/shop_screen.dart';
import 'package:shop_app_flutter/util/token_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final Future<Widget> home;

  Future<Widget> getHome() async {
    final token = await TokenManager.getToken();
    if (token != null) {
      return const ShopScreen();
    }
    return const AuthScreen();
  }

  @override
  void initState() {
    home = getHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder<Widget>(
        future: home,
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Scaffold(body: Text('Loading....'));
            default:
              if (snapshot.hasError || !snapshot.hasData) {
                return Scaffold(body: Text('Error: ${snapshot.error}'));
              } else {
                return snapshot.data!;
              }
          }
        },
      ),
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
