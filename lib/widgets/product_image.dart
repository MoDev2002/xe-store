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
                width: imgHeight,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return const Text('An error occurred');
                },
              ),
            ],
            alignment: Alignment.center,
          )
        : oval
            ? Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: bgHeight,
                    ),
                    ClipOval(
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        height: imgHeight,
                        width: imgHeight,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return const Text('An error occurred');
                        },
                      ),
                    ),
                  ],
                ),
              )
            : Image.network(
                imageUrl,
                fit: BoxFit.cover,
                height: bgHeight,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return const Text('An error occurred');
                },
              );
  }
}
