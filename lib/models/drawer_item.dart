import 'package:flutter/material.dart';

class DrawerItem {
  final String title;
  final IconData icon;
  final int index;
  const DrawerItem({
    required this.index,
    required this.title,
    required this.icon,
  });
}

class DrawerItems {
  static const home =
      DrawerItem(title: 'Home', icon: Icons.home_rounded, index: 0);
  static const cart =
      DrawerItem(title: 'My Cart', icon: Icons.shopping_cart_rounded, index: 1);
  static const favourites = DrawerItem(
      title: 'My Favourites', icon: Icons.favorite_rounded, index: 2);
  static const order =
      DrawerItem(title: 'My Orders', icon: Icons.assignment_rounded, index: 3);
  static const settings =
      DrawerItem(title: 'Settings', icon: Icons.settings_rounded, index: 4);

  static final List<DrawerItem> all = [
    home,
    cart,
    favourites,
    order,
    settings,
  ];
}
