import 'package:flutter/material.dart';

class PriceText extends StatelessWidget {
  final double price;
  final double fontSize;
  final Color? color;
  const PriceText({
    required this.price,
    required this.fontSize,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: '\$',
          style: TextStyle(
              fontSize: fontSize - 6,
              fontWeight: FontWeight.bold,
              color: color)),
      TextSpan(
          text: price.toStringAsFixed(2),
          style: TextStyle(
              fontSize: fontSize, fontWeight: FontWeight.bold, color: color))
    ]));
  }
}
