import 'package:flutter/foundation.dart';

import './cart.dart';

class OrderItem {
  final String id;
  final double totalPrice;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.totalPrice,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  // ignore: prefer_final_fields
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> products, double totalPrice) {
    _orders.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            totalPrice: totalPrice,
            products: products,
            dateTime: DateTime.now()));
    notifyListeners();
  }
}
