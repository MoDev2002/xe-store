import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

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

  Future<void> fetchOrders() async {
    final url = Uri.parse(
        'https://xe-store-default-rtdb.europe-west1.firebasedatabase.app/orders.json');
    final response = await http.get(url);
    if (json.decode(response.body) == null) {
      return;
    }
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final List<OrderItem> loadedOrders = [];
    extractedData.forEach((id, orderData) {
      loadedOrders.add(OrderItem(
          id: id,
          totalPrice: orderData['totalPrice'],
          products: (orderData['products'] as List<dynamic>)
              .map((cartItem) => CartItem(
                  id: cartItem['id'],
                  title: cartItem['title'],
                  imageUrl: cartItem['imageUrl'],
                  price: cartItem['price'],
                  quantity: cartItem['quantity']))
              .toList(),
          dateTime: DateTime.parse(orderData['dateTime'])));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> products, double totalPrice) async {
    final url = Uri.parse(
        'https://xe-store-default-rtdb.europe-west1.firebasedatabase.app/orders.json');
    final timeStamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'totalPrice': totalPrice,
          'dateTime': timeStamp.toIso8601String(),
          'products': products
              .map((cartItem) => {
                    'id': cartItem.id,
                    'title': cartItem.title,
                    'imageUrl': cartItem.imageUrl,
                    'price': cartItem.price,
                    'quantity': cartItem.quantity,
                  })
              .toList(),
        }));
    _orders.insert(
        0,
        OrderItem(
            id: json.decode(response.body)['name'],
            totalPrice: totalPrice,
            products: products,
            dateTime: timeStamp));
    notifyListeners();
  }
}
