import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shopapp/providers/products.dart';
import 'package:shopapp/screens/edit_product_screen.dart';
import 'package:shopapp/widgets/manage_product_item.dart';

class ManageProductsScreen extends StatelessWidget {
  final VoidCallback openDrawer;
  const ManageProductsScreen(this.openDrawer, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
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
        title: const Text(
          'Manage Products',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: '');
              },
              icon: const Icon(
                Icons.add_rounded,
                size: 28,
                color: Colors.black,
              ))
        ],
      ),
      body: ListView.builder(
        itemCount: products.items.length,
        itemBuilder: (context, index) => ManageProductItem(
            id: products.items[index].id,
            title: products.items[index].title,
            price: products.items[index].price,
            imageUrl: products.items[index].imageUrl),
      ),
    );
  }
}
