import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/products.dart';
import 'package:shopapp/screens/edit_product_screen.dart';
import 'package:shopapp/widgets/price_text.dart';
import 'package:shopapp/widgets/product_image.dart';

class ManageProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  const ManageProductItem(
      {Key? key,
      required this.id,
      required this.title,
      required this.price,
      required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      color: Colors.white,
      child: Row(
        children: [
          ProductImage(imageUrl: imageUrl, bgHeight: 100, imgHeight: 70),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 130,
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
                    price: (price),
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.primary)
              ],
            ),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
              icon: Icon(
                Icons.edit_rounded,
                color: Theme.of(context).colorScheme.primary,
              )),
          // SizedBox(width: 15),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          title: const Text('Are you sure'),
                          content: const Text(
                              'That you want to remove this product permanently?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('No',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary))),
                            TextButton(
                                onPressed: () {
                                  Provider.of<Products>(context, listen: false)
                                      .removeProduct(id);
                                  Navigator.of(context).pop();
                                },
                                child: Text('Yes',
                                    style: TextStyle(
                                        color: Theme.of(context).errorColor))),
                          ],
                        ));
              },
              icon: Icon(
                Icons.delete_forever_rounded,
                color: Theme.of(context).errorColor,
              )),
        ],
      ),
    );
  }
}
