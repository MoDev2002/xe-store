import 'package:flutter/material.dart';
import 'package:shopapp/screens/manage_products_screen.dart';
import 'package:shopapp/screens/settings_screen.dart';

import '../models/drawer_item.dart';
import './cart_screen.dart';
import './tabs_screen.dart';
import '../widgets/drawer_widget.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  late double xOffset;
  late double yOffset;
  late double scaleFactor;
  late bool isDrawerOpen;
  int selectedIndex = 0;
  DrawerItem item = DrawerItems.home;
  bool isDragging = false;

  @override
  void initState() {
    super.initState();
    closeDrawer();
  }

  void closeDrawer() => setState(() {
        xOffset = 0;
        yOffset = 0;
        scaleFactor = 1;
        isDrawerOpen = false;
      });
  void openDrawer() => setState(() {
        xOffset = 270;
        yOffset = 150;
        scaleFactor = 0.65;
        isDrawerOpen = true;
      });
  Widget _buildDrawer() => DrawerWidget(
        selectedIndex,
        onSelectedItem: (item) {
          setState(() {
            this.item = item;
          });
          closeDrawer();
        },
      );
  Widget _buildPage() {
    return WillPopScope(
      onWillPop: () async {
        if (isDrawerOpen) {
          closeDrawer();
          return false;
        } else {
          return true;
        }
      },
      child: GestureDetector(
        onTap: closeDrawer,
        onHorizontalDragStart: (details) => isDragging = true,
        onHorizontalDragUpdate: (details) {
          const delta = 1;
          if (details.delta.dx > delta) {
            openDrawer();
          } else if (details.delta.dx < -delta) {
            closeDrawer();
          }
        },
        child: AnimatedContainer(
            transform: Matrix4.translationValues(xOffset, yOffset, 0)
              ..scale(scaleFactor),
            duration: const Duration(milliseconds: 250),
            child: AbsorbPointer(
                absorbing: isDrawerOpen,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(isDrawerOpen ? 35 : 0),
                    child: getDrawerPage()))),
      ),
    );
  }

  Widget getDrawerPage() {
    switch (item) {
      case DrawerItems.manageProducts:
        selectedIndex = 1;
        return ManageProductsScreen(openDrawer);
      case DrawerItems.settings:
        selectedIndex = 2;
        return SettingsScreen(openDrawer);
      case DrawerItems.home:
      default:
        selectedIndex = 0;
        return TabsScreen(openDrawer);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Stack(children: [
        _buildDrawer(),
        _buildPage(),
      ]),
    );
  }
}
