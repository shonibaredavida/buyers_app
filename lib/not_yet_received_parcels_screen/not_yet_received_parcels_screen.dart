import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trial/global/global.dart';
import 'package:trial/orders_screen/order_card.dart';

class NotYetReceivedParcelScreen extends StatefulWidget {
  const NotYetReceivedParcelScreen({Key? key}) : super(key: key);

  @override
  State<NotYetReceivedParcelScreen> createState() =>
      _NotYetReceivedParcelScreenState();
}

class _NotYetReceivedParcelScreenState
    extends State<NotYetReceivedParcelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        flexibleSpace: Container(
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
          )),
        ),
        title: const Text(
          "Parcels on Transit",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(sharedPreferences!.getString("uid"))
            .collection("orders")
            .where("status", isEqualTo: "shifted")
            .where("orderBy", isEqualTo: sharedPreferences!.getString("uid"))
            .orderBy("orderTime", descending: true)
            .snapshots(),
        builder: (c, AsyncSnapshot dataSnapShot) {
          if (dataSnapShot.hasData) {
            return ListView.builder(
              itemCount: dataSnapShot.data.docs.length,
              itemBuilder: (c, index) {
                return FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("items")
                      .where("itemID",
                          whereIn: cartMethods.separateOrderItemIDs(
                              (dataSnapShot.data.docs[index].data()
                                  as Map<String, dynamic>)["productIDs"]))
                      .where("orderBy  ",
                          whereIn: (dataSnapShot.data.docs[index].data()
                              as Map<String, dynamic>)["uid"])
                      .orderBy("publishedDate", descending: true)
                      .get(),
                  builder: (c, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (dev) {
                        printo("displayed the orders accordingly");
                      }
                      return OrderCart(
                        itemCounts: snapshot.data.docs.length,
                        data: snapshot.data.docs,
                        orderId: dataSnapShot.data.docs[index].id,
                        separateQuantityList: cartMethods.separateOrderItemQty(
                            (dataSnapShot.data.docs[index].data()
                                as Map<String, dynamic>)["productIDs"]),
                      );
                    } else {
                      if (dev) {
                        printo("No order to display2");
                      }
                      return const Center(
                        child: Text(
                          "No data exists.",
                          style: TextStyle(color: Colors.white54),
                        ),
                      );
                    }
                  },
                );
              },
            );
          } else {
            if (dev) {
              printo("No order to display1");
            }
            return const Center(
              child: Text(
                "No data exists.",
                style: TextStyle(color: Colors.white54),
              ),
            );
          }
        },
      ),
    );
  }
}
