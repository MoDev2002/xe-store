import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String descreption;
  final double price;
  final String imageUrl;
  Product({
    required this.id,
    required this.title,
    required this.descreption,
    required this.price,
    required this.imageUrl,
  });
  Product copyWith({
    String? id,
    String? title,
    String? descreption,
    double? price,
    String? imageUrl,
  }) {
    return Product(
        id: id ?? this.id,
        title: title ?? this.title,
        descreption: descreption ?? this.descreption,
        price: price ?? this.price,
        imageUrl: imageUrl ?? this.imageUrl);
  }
}
