import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'product.dart';

class Products with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Nike Air Max 20',
    //   descreption: 'Built for natural motion, the Nike Flex shoes',
    //   price: 240.00,
    //   imageUrl:
    //       'https://cdn.vox-cdn.com/thumbor/KZrQTQDFFlRDRpabcgXjILV343E=/0x0:3144x3144/1400x1400/filters:focal(1321x1321:1823x1823):format(png)/cdn.vox-cdn.com/uploads/chorus_image/image/50217517/AM1_20Ultra_20Flyknit_207.0.png',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Apple Watch Nike SE',
    //   descreption: 'Apple Watch. Your Watch. Your Way',
    //   price: 399.99,
    //   imageUrl:
    //       'https://res-5.cloudinary.com/grover/image/upload/e_trim/c_limit,f_auto,fl_png8.lossy,h_1280,q_auto,w_1280/v1600694320/zgllslafh6o4pmagcs7w.png',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Pace 20 Backpack',
    //   descreption: 'More essential than your morninig coffe',
    //   price: 99.99,
    //   imageUrl:
    //       'https://www.ogio.com/dw/image/v2/AADH_PRD/on/demandware.static/-/Sites-CGI-ItemMaster/en_US/v1631938545711/sits/ogio-backpack-2020-pace-20/ogio-backpack-2020-pace-20_11546___1.png?sfrm=png&sw=600',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'Air Jordan 3',
    //   descreption: 'Handmade for your joy',
    //   price: 249.45,
    //   imageUrl:
    //       'https://sneakerbardetroit.com/wp-content/uploads/2021/04/Air-Jordan-1-Design-Studio-Sample-885800PROMO-Release-Date-1.png',
    // ),
    // Product(
    //   id: 'p5',
    //   title: 'Samsung Watch Active 2',
    //   descreption: 'The smart wearable that\'s with you every step of the way',
    //   price: 300.00,
    //   imageUrl:
    //       'https://cdn.shopify.com/s/files/1/0022/6728/3545/products/Samsung_Galaxy_Watch_Active_2_40mm_-_Black_1000x.png?v=1572353425',
    // ),
    // Product(
    //   id: 'p6',
    //   title: 'OnePlus Urban Traveler Backpack',
    //   descreption: 'A smarter design for hassle-free traveling',
    //   price: 89.99,
    //   imageUrl:
    //       'https://image01.oneplus.net/ebp/202012/22/1-m00-1e-ac-rb8bwl_hx1mactthaaoaihemalq654.png',
    // ),
  ];

  List<Product> get items {
    return [..._items];
  }

  findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    final url = Uri.parse(
        'https://xe-store-default-rtdb.europe-west1.firebasedatabase.app/products.json');
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final List<Product> loadedProducts = [];
    extractedData.forEach((prodId, prodData) {
      loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          descreption: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl']));
    });
    _items = loadedProducts;
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        'https://xe-store-default-rtdb.europe-west1.firebasedatabase.app/products.json');
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.descreption,
            'price': product.price,
            'imageUrl': product.imageUrl,
          }));
      _items.insert(
          0,
          product.copyWith(
            id: json.decode(response.body)['name'],
          ));
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateProduct(String id, Product product) async {
    final url = Uri.parse(
        'https://xe-store-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json');
    await http.patch(url,
        body: json.encode({
          'title': product.title,
          'description': product.descreption,
          'price': product.price,
          'imageUrl': product.imageUrl,
        }));

    final favIndex = favorites.indexWhere((fav) => fav.id == id);
    if (favIndex >= 0) {
      favorites[favIndex] = product;
    }
    notifyListeners();
  }

  void removeProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    favorites.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }

  List<Product> favorites = [];

  void toggleFavorite(String id) {
    final existingIndex = favorites.indexWhere((product) => product.id == id);
    if (existingIndex >= 0) {
      favorites.removeAt(existingIndex);
      notifyListeners();
    } else {
      favorites.add(_items.firstWhere((product) => product.id == id));
      notifyListeners();
    }
  }

  bool isFavorite(String id) {
    return favorites.any((product) => product.id == id);
  }
}
