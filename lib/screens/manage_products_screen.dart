import 'package:flutter/material.dart';

class ManageProductsScreen extends StatelessWidget {
  final VoidCallback openDrawer;
  const ManageProductsScreen(this.openDrawer, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
              onPressed: openDrawer,
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
    );
  }
}
