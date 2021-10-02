import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';
import '../providers/products.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteProducts = Provider.of<Products>(context).favorites;
    var showFavorite = true;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'My Favorites',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
        ),
        Expanded(
          child: favoriteProducts.isEmpty
              ? const Center(
                  child: Text(
                    'no Favorites yet!, Start adding Some.',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                )
              : ProductsGrid(showFavorite),
        ),
      ],
    );
  }
}
