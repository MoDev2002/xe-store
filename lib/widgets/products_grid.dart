import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavorite;
  const ProductsGrid(this.showFavorite, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final products = productData.items;
    final favoriteProducts = productData.favorites;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: showFavorite ? favoriteProducts[i] : products[i],
        child: const ProductItem(),
      ),
      itemCount: showFavorite ? favoriteProducts.length : products.length,
    );
  }
}
