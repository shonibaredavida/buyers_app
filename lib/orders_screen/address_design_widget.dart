import 'package:flutter/material.dart';
import 'package:trial/global/global.dart';
import 'package:trial/models/address_model.dart';

class AddressDesign extends StatelessWidget {
  Address? model;
  String? orderStatus;
  String? orderId;
  String? sellerId;
  String? orderedByUser;
  AddressDesign(
      {this.model,
      this.sellerId,
      this.orderId,
      this.orderStatus,
      this.orderedByUser});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Shipping Details",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        sizedBox(height: 5),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(
            horizontal: 90,
            vertical: 5,
          ),
          child: Table(
            children: [
              TableRow(children: [
                const Text(
                  "Name",
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  model!.name.toString(),
                  style: const TextStyle(color: Colors.grey),
                ),
              ]),
              TableRow(children: [sizedBox(height: 4), sizedBox(height: 4)]),
              TableRow(children: [sizedBox(height: 4), sizedBox(height: 4)]),
              TableRow(children: [
                const Text(
                  "Phone Number",
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  model!.phoneNumber.toString(),
                  style: const TextStyle(color: Colors.grey),
                ),
              ]), /* TableRow(children: [
                const Text(
                  "Full Address ",
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  model!.completeAddress.toString(),
                  style: const TextStyle(color: Colors.grey),
                ),
              ]), */
            ],
          ),
        ),
        sizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            model!.completeAddress.toString(),
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        sizedBox(height: 5),
      ],
    );
  }
}
