import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderCart extends StatefulWidget {
  OrderCart(
      {this.data, this.itemCounts, this.orderId, this.separateQuantityList});
  int? itemCounts;
  List<DocumentSnapshot>? data;
  String? orderId;
  List<String>? separateQuantityList;

  @override
  State<OrderCart> createState() => _OrderCartState();
}

class _OrderCartState extends State<OrderCart> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red,
      elevation: 10,
      shadowColor: Colors.white54,
      child: Container(
        color: Colors.white54,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        height: widget.itemCounts! * 125,
      ),
    );
  }
}
