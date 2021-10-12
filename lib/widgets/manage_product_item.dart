import 'package:flutter/material.dart';
import 'package:shopapp/widgets/price_text.dart';

class ManageProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double price;
  const ManageProductItem(
      {Key? key,
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
                    color: Theme.of(context).colorScheme.secondary)
              ],
            ),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.edit_rounded,
                color: Theme.of(context).colorScheme.secondary,
              )),
          // SizedBox(width: 15),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.delete_forever_rounded,
                color: Theme.of(context).errorColor,
              )),
        ],
      ),
    );
  }
}
