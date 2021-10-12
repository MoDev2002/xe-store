import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/price_text.dart';
import '../providers/cart.dart';
import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct = Provider.of<Products>(context).findById(productId);
    final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            RichText(
                text: TextSpan(
                    style: const TextStyle(
                        fontFamily: 'Amiko',
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                    children: [
                  TextSpan(
                      text: 'X',
                      style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.secondaryVariant)),
                  TextSpan(
                      text: 'E',
                      style: TextStyle(color: Theme.of(context).primaryColor))
                ])),
          ],
        ),
        leading: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                  size: 28,
                )),
          ],
        ),
        actions: [
          Consumer<Products>(
            builder: (ctx, products, child) => Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  height: 35,
                  width: 35,
                  child: FittedBox(
                    child: FloatingActionButton(
                        heroTag: null,
                        elevation: 0,
                        backgroundColor: products.isFavorite(productId)
                            ? Colors.pink
                            : Colors.white,
                        onPressed: () => products.toggleFavorite(productId),
                        child: products.isFavorite(productId)
                            ? const Icon(
                                Icons.favorite_rounded,
                                size: 34,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.favorite_rounded,
                                size: 34,
                                color: Colors.grey,
                              )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(
                  height: 75,
                ),
                Stack(
                  children: [
                    Image.asset(
                      'assets/images/product_background.png',
                      height: 400,
                    ),
                    Image.network(
                      loadedProduct.imageUrl,
                      fit: BoxFit.contain,
                      height: 330,
                    ),
                  ],
                  alignment: Alignment.center,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 450),
            child: Container(
                height: MediaQuery.of(context).size.height - 400,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 300,
                            child: Text(
                              loadedProduct.title,
                              softWrap: true,
                              style: TextStyle(
                                  fontSize: 26,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondaryVariant,
                                  fontWeight: FontWeight.bold),
                              maxLines: 2,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '4.7',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Icon(
                              Icons.star_rate_rounded,
                              color: Colors.amber,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, bottom: 20),
                      child: Text(
                        loadedProduct.descreption,
                        softWrap: true,
                        style: TextStyle(
                            fontSize: 18,
                            color:
                                Theme.of(context).colorScheme.secondaryVariant),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 80,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35)),
                      ),
                      child: Row(
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: PriceText(
                                  price: loadedProduct.price,
                                  fontSize: 28,
                                  color: Colors.black)),
                          const Spacer(),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  cart.addItem(
                                      productId,
                                      loadedProduct.title,
                                      loadedProduct.imageUrl,
                                      loadedProduct.price);
                                  ScaffoldMessenger.of(context)
                                    ..removeCurrentSnackBar()
                                    ..showSnackBar(SnackBar(
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      duration: Duration(seconds: 1),
                                      content: const Text('Item added to cart'),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15))),
                                      action: SnackBarAction(
                                        textColor:
                                            Theme.of(context).primaryColor,
                                        label: 'UNDO',
                                        onPressed: () {
                                          cart.addOrRemoveItem(
                                              loadedProduct.id, false);
                                        },
                                      ),
                                    ));
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Theme.of(context)
                                                .scaffoldBackgroundColor),
                                    elevation:
                                        MaterialStateProperty.all<double>(7),
                                    shape: MaterialStateProperty.all<OutlinedBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                    padding:
                                        MaterialStateProperty.all<EdgeInsetsGeometry>(
                                            const EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 10))),
                                child: Row(
                                  children: [
                                    Icon(Icons.shopping_cart_rounded,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondaryVariant),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Add To Cart',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondaryVariant,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                )),
                          )
                        ],
                      ),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
