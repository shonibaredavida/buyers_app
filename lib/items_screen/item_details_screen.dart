import 'package:cart_stepper/cart_stepper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:trial/assistant_method/cart_item_counter.dart';
import 'package:trial/global/global.dart';
import 'package:trial/models/items_models.dart';
import 'package:trial/widgets/appbar_cart_badget.dart';

class ItemsDetailsScreen extends StatefulWidget {
  ItemsDetailsScreen({this.model});
  Items? model;
  @override
  State<ItemsDetailsScreen> createState() => _ItemsDetailsScreenState();
}

class _ItemsDetailsScreenState extends State<ItemsDetailsScreen> {
  int counterLimit = 1;
  @override
  void didChangeDependencies() {
    Provider.of<CartItemCounter>(context).showCartListItemsNumber();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBarWithCartBadge(sellerUID: widget.model!.sellerUID),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          int itemCounter = counterLimit;
          //add to cart increase the number per click
          //check if item is in cart
          List<String> itemIDsList =
              cartMethods.separateItemIDsFromUserCartList();
          if (itemIDsList.contains(widget.model!.itemID)) {
            if (dev) print("WE WE WE WE already in list");

            Fluttertoast.showToast(msg: "Item already in the Cart");
          } else {
            //if not add to cart
            if (dev) print("WE WE WE WE Not in list");

            cartMethods.addItemToCart(
                itemID: widget.model!.itemID.toString(),
                itemCounter: itemCounter,
                context: context);
            if (dev) print(" WE WE WE WE adding Item to cart");
          }
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
            //implement specific number to be
            //added to cart

            Center(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CartStepperInt(
                        size: 50,
                        deActiveBackgroundColor: Colors.red,
                        activeBackgroundColor: Colors.pinkAccent,
                        activeForegroundColor: Colors.white,
                        count: counterLimit,
                        didChangeCount: (value) {
                          if (value < 1) {
                            if (dev) print(" WE WE WE  brands exist object");
                            Fluttertoast.showToast(
                                msg: "Item cannot be lesser than 1 ");
                            return;
                          }
                          setState(() {
                            counterLimit = value;
                          });
                        }))),
            //implement specific number to be
            //added to cart

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
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontSize: 15),
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
            sizedBox(height: 10),
          ]),
        ),
      ),
    );
  }
}
