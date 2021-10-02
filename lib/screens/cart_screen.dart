import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../widgets/price_text.dart';
import '../widgets/cart_item.dart';
import '../providers/cart.dart' show Cart;

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: const [
            SizedBox(
              height: 8,
            ),
            Text(
              'My Cart',
              style: TextStyle(color: Colors.black, fontSize: 28),
            ),
          ],
        ),
        leading: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/');
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                  size: 28,
                )),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                      itemCount: cart.itemCount,
                      itemBuilder: (context, i) {
                        return CartItem(
                          id: cart.items.values.toList()[i].id,
                          productId: cart.items.keys.toList()[i],
                          title: cart.items.values.toList()[i].title,
                          imageUrl: cart.items.values.toList()[i].imageUrl,
                          price: cart.items.values.toList()[i].price,
                          quantity: cart.items.values.toList()[i].quantity,
                        );
                      },
                    ),
                  )),
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
                                price: cart.totalAmount,
                                fontSize: 28,
                                color: Colors.black)),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: ElevatedButton(
                              onPressed: () {
                                Provider.of<Orders>(context, listen: false)
                                    .addOrder(cart.items.values.toList(),
                                        cart.totalAmount);
                                cart.clearCart();
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Theme.of(context)
                                              .colorScheme
                                              .secondaryVariant),
                                  elevation:
                                      MaterialStateProperty.all<double>(7),
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30))),
                                  padding:
                                      MaterialStateProperty.all<EdgeInsetsGeometry>(
                                          const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 10))),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check_circle_outline_rounded,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Check Out',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
