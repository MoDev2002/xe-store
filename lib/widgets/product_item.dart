import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './product_image.dart';
import './price_text.dart';
import '../providers/cart.dart';
import '../providers/product.dart';
import '../providers/products.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        ProductDetailScreen.routeName,
        arguments: product.id,
      ),
      child: Card(
        margin: const EdgeInsets.all(10),
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).primaryColor),
                    child: const Text(
                      '20%',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Spacer(),
                  Consumer<Products>(
                    builder: (ctx, products, child) => Container(
                      margin: const EdgeInsets.all(5),
                      height: 32,
                      width: 32,
                      child: FittedBox(
                        child: FloatingActionButton(
                            heroTag: null,
                            elevation: 0,
                            backgroundColor: products.isFavorite(product.id)
                                ? Colors.pink
                                : Colors.white,
                            onPressed: () =>
                                products.toggleFavorite(product.id),
                            child: products.isFavorite(product.id)
                                ? const Icon(
                                    Icons.favorite_rounded,
                                    size: 30,
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    Icons.favorite_rounded,
                                    size: 30,
                                    color: Colors.grey,
                                  )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ProductImage(
                imageUrl: product.imageUrl, bgHeight: 120, imgHeight: 90),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                product.title,
                style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.secondaryVariant,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 5),
            PriceText(
                price: product.price,
                fontSize: 22,
                color: Theme.of(context).colorScheme.primary),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      cart.addItem(product.id, product.title, product.imageUrl,
                          product.price);
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          duration: const Duration(seconds: 1),
                          content: const Text('Item added to cart'),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15))),
                          action: SnackBarAction(
                            textColor: Theme.of(context).primaryColor,
                            label: 'UNDO',
                            onPressed: () {
                              cart.addOrRemoveItem(product.id, false);
                            },
                          ),
                        ));
                    },
                    icon: const Icon(Icons.shopping_cart_rounded)),
                const Spacer(),
                const Text(
                  '4.7',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Icon(
                    Icons.star_rate_rounded,
                    color: Colors.amber,
                    size: 22,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
