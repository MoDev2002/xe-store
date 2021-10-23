import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/products.dart';

import '../widgets/products_grid.dart';

class ProductOverreviewScreen extends StatefulWidget {
  const ProductOverreviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverreviewScreen> createState() =>
      _ProductOverreviewScreenState();
}

class _ProductOverreviewScreenState extends State<ProductOverreviewScreen> {
  bool isInit = true;
  var isLoading = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((value) {
        setState(() {
          isLoading = false;
        });
      });
    }
    isInit = false;
  }

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
        Expanded(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                : ProductsGrid(showFavorite)),
      ],
    );
  }
}
