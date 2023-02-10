import 'package:flutter/material.dart';
import 'package:trial/global/global.dart';
import 'package:trial/models/address_model.dart';
import 'package:trial/splashScreen/my_splash_screen.dart';

class AddressDesign extends StatelessWidget {
  final Address? model;
  final String? orderStatus;
  final String? orderId;
  final String? sellerId;
  final String? orderedByUser;
  const AddressDesign(
      {super.key,
      this.model,
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
        GestureDetector(
          onTap: () {
            if (orderStatus == "ended") {
              //implement reorder the same cart
            } else if (orderStatus == "shifted") {
              //implement "Parcel Delivered and Received "
            } else if (orderStatus == "normal") {
              Navigator.pop(context);
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MySplashScreen()));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.pinkAccent,
                      Colors.purpleAccent,
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp,
                  ),
                ),
                width: MediaQuery.of(context).size.width - 40,
                height: orderStatus == "ended"
                    ? 60
                    : MediaQuery.of(context).size.height * 0.08,
                child: Center(
                  child: Text(
                    orderStatus == "ended"
                        ? "Do you want to Rate the seller?"
                        : orderStatus == "Shifted"
                            ? "Parcel Delivered and Received \n Click to Confirm"
                            : orderStatus == "normal"
                                ? "Go Back"
                                : "",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                )),
          ),
        )
      ],
    );
  }
}
