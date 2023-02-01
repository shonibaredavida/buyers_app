import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trial/cart_screens/cart_item_design.dart';
import 'package:trial/global/global.dart';
import 'package:trial/models/items_models.dart';
import 'package:trial/splashScreen/my_splash_screen.dart';
import 'package:trial/widgets/appbar_cart_badget.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key, this.sellerUID});
  String? sellerUID;
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<int>? ItemQty = cartMethods.separateItemQtyFromUserCartList();
  @override
  void initState() {
    // TODO: implement initState
    ItemQty = cartMethods.separateItemQtyFromUserCartList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBarWithCartBadge(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          sizedBox(height: 10),
          FloatingActionButton.extended(
            onPressed: () {
              cartMethods.clearCart(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => const MySplashScreen()));
            },
            heroTag: "btn1",
            label: const Text(
              "Clear Cart",
              style: TextStyle(fontSize: 16),
            ),
            icon: const Icon(Icons.clear_all),
          ),
          FloatingActionButton.extended(
            onPressed: () {},
            heroTag: "btn2",
            label: const Text(
              "Check Out",
              style: TextStyle(fontSize: 16),
            ),
            icon: const Icon(Icons.navigate_next),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverToBoxAdapter(
            child: Center(
              child: Text(
                "TOTal Price : {}",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // in display information from firebase
          // we required the following model , design and a query
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("items")
                .where("itemID",
                    whereIn: cartMethods.separateItemIDsFromUserCartList())
                .orderBy("publishedDate")
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    Items model = Items.fromJson(snapshot.data.docs[index]
                        .data() as Map<String, dynamic>);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CartItemDesign(
                        model: model,
                        qty: ItemQty![index],
                      ),
                    );
                  }, childCount: snapshot.data.docs.length),
                );
              } else {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      "NO Item selected",
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
