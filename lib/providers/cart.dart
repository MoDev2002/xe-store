import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  final int quantity;
  CartItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });
}

class Cart with ChangeNotifier {
  // ignore: prefer_final_fields
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, String title, String imageUrl, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              imageUrl: existingCartItem.imageUrl,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity + 1));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
                id: DateTime.now().toString(),
                title: title,
                imageUrl: imageUrl,
                price: price,
                quantity: 1,
              ));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void addOrRemoeItem(String productId, bool add) {
    _items.update(
        productId,
        (existingItem) => CartItem(
              id: existingItem.id,
              title: existingItem.title,
              imageUrl: existingItem.imageUrl,
              price: existingItem.price,
              quantity:
                  add ? existingItem.quantity + 1 : existingItem.quantity - 1,
            ));
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
