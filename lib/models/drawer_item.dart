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
  static const manageProducts =
      DrawerItem(index: 1, title: 'Manage Products', icon: Icons.edit_rounded);
  static const settings =
      DrawerItem(title: 'Settings', icon: Icons.settings_rounded, index: 2);

  static final List<DrawerItem> all = [
    home,
    manageProducts,
    settings,
  ];
}
