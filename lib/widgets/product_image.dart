import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String imageUrl;
  final double bgHeight;
  final double imgHeight;
  final bool oval;
  const ProductImage({
    Key? key,
    required this.imageUrl,
    required this.bgHeight,
    required this.imgHeight,
    this.oval = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageUrl.contains('.png')
        ? Stack(
            children: [
              Image.asset(
                'assets/images/product_background.png',
                height: bgHeight,
              ),
              Image.network(
                imageUrl,
                fit: BoxFit.contain,
                height: imgHeight,
              ),
            ],
            alignment: Alignment.center,
          )
        : oval
            ? ClipOval(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  height: bgHeight,
                ),
              )
            : Image.network(
                imageUrl,
                fit: BoxFit.contain,
                height: bgHeight,
              );
  }
}
