import 'package:flutter/material.dart';
import 'package:trial/global/global.dart';

class PlaceOrderScreen extends StatefulWidget {
  PlaceOrderScreen({
    this.addressID,
    this.sellerUID,
    this.totalAmount,
  });
  String? addressID;
  String? totalAmount;
  String? sellerUID;
  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("images/delivery.png"),
          sizedBox(
            height: 12,
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text("Place Order Now"),
          )
        ],
      ),
    );
  }
}
