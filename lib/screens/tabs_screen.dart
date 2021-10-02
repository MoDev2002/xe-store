import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/orders_screen.dart';
import '../providers/cart.dart';
import './cart_screen.dart';
import '../widgets/badge.dart';
import '../widgets/tabbar_material.dart';
import './favorites_screen.dart';
import './product_overreview_screen.dart';

// ignore: must_be_immutable
class TabsScreen extends StatefulWidget {
  final VoidCallback openDrawer;
  int selectedIndex = 0;
  TabsScreen(this.openDrawer, this.selectedIndex, {Key? key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Widget> _screens = const [
    ProductOverreviewScreen(),
    FavoritesScreen(),
    OrdersScreen(),
    Text('Profile'),
  ];

  void _selectScreen(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
              onPressed: widget.openDrawer,
              icon: const Icon(
                Icons.menu_rounded,
                color: Colors.black,
                size: 32,
              )),
          title: RichText(
              text: TextSpan(
                  style: const TextStyle(
                      fontFamily: 'Amiko',
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                  children: [
                TextSpan(
                    text: 'X',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondaryVariant)),
                TextSpan(
                    text: 'E',
                    style: TextStyle(color: Theme.of(context).primaryColor))
              ]))),
      body: _screens[widget.selectedIndex],
      floatingActionButton: Consumer<Cart>(
        builder: (ctx, cart, ch) => cart.itemCount == 0
            ? ch as Widget
            : Badge(
                value: cart.itemCount.toString(),
                child: ch as Widget,
              ),
        child: FloatingActionButton(
            elevation: 10,
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
            child: Icon(
              Icons.shopping_cart_rounded,
              color: Theme.of(context).primaryColor,
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: TabBarMaterial(
          index: widget.selectedIndex, onChangedTab: _selectScreen),
    );
  }
}
