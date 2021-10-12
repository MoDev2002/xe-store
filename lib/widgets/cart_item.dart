import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './price_text.dart';
import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;
  final String imageUrl;
  const CartItem({
    Key? key,
    required this.id,
    required this.productId,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Dismissible(
      onDismissed: (direction) {
        cart.removeItem(productId);
      },
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  title: const Text('Are you sure'),
                  content: const Text('You want to remove item from cart ?'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text('No',
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.secondary))),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text('Yes',
                            style: TextStyle(
                                color: Theme.of(context).errorColor))),
                  ],
                ));
      },
      direction: DismissDirection.endToStart,
      key: ValueKey(id),
      background: Container(
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).errorColor),
        child: const Icon(
          Icons.delete_rounded,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        color: Colors.white,
        child: Row(
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/product_background.png',
                  height: 100,
                ),
                Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  height: 70,
                ),
              ],
              alignment: Alignment.center,
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 170,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.secondaryVariant,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  PriceText(
                      price: (price * quantity),
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.secondary)
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                    width: 25,
                    child: FittedBox(
                      child: FloatingActionButton(
                        heroTag: null,
                        backgroundColor: Colors.white,
                        elevation: 1,
                        onPressed: () {
                          cart.addOrRemoveItem(productId, false);
                        },
                        child: const Icon(
                          Icons.remove_rounded,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      quantity.toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                    width: 25,
                    child: FittedBox(
                      child: FloatingActionButton(
                        heroTag: null,
                        elevation: 1,
                        backgroundColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          cart.addOrRemoveItem(productId, true);
                        },
                        child: const Icon(
                          Icons.add_rounded,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
