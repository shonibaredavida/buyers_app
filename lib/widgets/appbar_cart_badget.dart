import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trial/assistant_method/cart_item_counter.dart';
import 'package:trial/cart_screens/cart_screen.dart';

class AppBarWithCartBadge extends StatefulWidget with PreferredSizeWidget {
  AppBarWithCartBadge({this.preferredSizedWidget, this.sellerUID});
  PreferredSizeWidget? preferredSizedWidget;
  String? sellerUID;
  @override
  State<AppBarWithCartBadge> createState() => _AppBarWithCartBadgeState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => preferredSizedWidget == null
      ? Size(56, AppBar().preferredSize.height)
      : Size(56, 80 + AppBar().preferredSize.height);
}

class _AppBarWithCartBadgeState extends State<AppBarWithCartBadge> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      automaticallyImplyLeading: true,
      centerTitle: true,
      title: const Text(
        "iShop",
        style: TextStyle(fontSize: 20, letterSpacing: 2),
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        CartScreen(sellerUID: widget.sellerUID),
                  ),
                );
              },
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
            Positioned(
                child: Stack(
              children: [
                const Icon(
                  Icons.brightness_1,
                  size: 20,
                  color: Colors.deepPurpleAccent,
                ),
                Positioned(
                  top: 3,
                  right: 4,
                  child:
                      Consumer<CartItemCounter>(builder: (context, counter, c) {
                    return Text(
                      counter.count.toString(),
                      style: const TextStyle(color: Colors.white),
                    );
                  }),
                )
              ],
            ))
          ],
        )
      ],
    );
  }
}
