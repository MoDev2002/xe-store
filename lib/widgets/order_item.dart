import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './price_text.dart';
import '../providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;
  const OrderItem(
    this.order, {
    Key? key,
  }) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      child: Column(
        children: [
          ListTile(
            title: PriceText(
                price: widget.order.totalPrice,
                fontSize: 22,
                color: Colors.black),
            subtitle:
                Text(DateFormat.yMEd().add_jm().format(widget.order.dateTime)),
            trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                icon: Icon(
                    _expanded
                        ? Icons.expand_less_rounded
                        : Icons.expand_more_rounded,
                    size: 30)),
          ),
          if (_expanded)
            Container(
              height: min(widget.order.products.length * 30 + 100, 200),
              child: ListView(
                children: widget.order.products
                    .map((prod) => Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${prod.quantity} x',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    prod.title,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Spacer(),
                                  PriceText(
                                      price: prod.price,
                                      fontSize: 18,
                                      color: Colors.black)
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Status : Delivered',
                                    style: TextStyle(
                                        color: Colors.grey[700], fontSize: 14),
                                  ),
                                  PriceText(
                                      price: prod.price * prod.quantity,
                                      fontSize: 14,
                                      color: Colors.grey[700])
                                ],
                              )
                            ],
                          ),
                        ))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
