import 'package:cart_stepper/cart_stepper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trial/global/global.dart';
import 'package:trial/models/items_models.dart';

class ItemsDetailsScreen extends StatefulWidget {
  ItemsDetailsScreen({this.model});
  Items? model;
  @override
  State<ItemsDetailsScreen> createState() => _ItemsDetailsScreenState();
}

class _ItemsDetailsScreenState extends State<ItemsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    int counterLimit = 1;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model!.itemTitle.toString()),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.green,
                  Colors.black,
                  Colors.red,
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                // stops: [0.0, 1.0],  #check
                tileMode: TileMode.clamp),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (dev) print(" WE WE WE WE adding Item to cart");
          //add to cart increase the number per click
        },
        label: const Text("Add to Cart"),
        icon: const Icon(
          Icons.add_shopping_cart_rounded,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                widget.model!.thumbnailUrl.toString(),
              ),
            ),
            sizedBox(height: 10),
            //implement specific number to be added to cart
            /*  CartStepperInt(
              count: counterLimit,
              didChangeCount: (cartNumber) {
                if (cartNumber < 0) {
                  if (dev) print(" WE WE WE WE brands exist object");
                  Fluttertoast.showToast(msg: "dfbbdfjb");
                  return;
                }

                setState(() {
                  counterLimit = cartNumber;
                });
              },
            ), */
            sizedBox(),

            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8),
              child: Text(
                widget.model!.itemTitle.toString(),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  color: Colors.pinkAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6, right: 8, left: 8),
              child: Text(
                widget.model!.longDescription.toString(),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 9, right: 8, left: 8),
              child: Text(
                "₦ ${widget.model!.price.toString()}  ",
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  shadows: [
                    Shadow(color: Colors.pinkAccent, offset: Offset(0, -7))
                  ],
                  color: Colors.transparent,
                  decoration: TextDecoration.underline,
                  decorationThickness: 4,
                  decorationColor: Colors.pink,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
