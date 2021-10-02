import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

class ProductOverreviewScreen extends StatelessWidget {
  const ProductOverreviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var showFavorite = false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Recommended Products',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
        ),
        Expanded(child: ProductsGrid(showFavorite)),
      ],
    );
  }
}
