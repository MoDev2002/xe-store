import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/screens/drawer_screen.dart';

import './providers/orders.dart';
import './screens/cart_screen.dart';
import './providers/cart.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => Orders())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Shop',
        theme: ThemeData(
            scaffoldBackgroundColor: const Color.fromARGB(255, 245, 245, 245),
            fontFamily: 'Gilroy',
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 245, 245, 245),
              secondaryVariant: Color.fromRGBO(37, 60, 120, 1),
              secondary: Color.fromRGBO(43, 98, 195, 1),
            ),
            primaryColor: const Color.fromRGBO(163, 219, 243, 1)),
        routes: {
          '/': (ctx) => const DrawerScreen(),
          ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
          CartScreen.routeName: (ctx) => const CartScreen()
        },
      ),
    );
  }
}
