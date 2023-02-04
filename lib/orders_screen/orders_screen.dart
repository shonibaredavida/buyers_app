import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trial/assistant_method/cart_methods.dart';
import 'package:trial/global/global.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "iShop",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(sharedPreferences!.getString("uid"))
            .collection("orders")
            .where("status", isEqualTo: "normal")
            .orderBy(("orderTime"), descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.docs.lenght,
              itemBuilder: (BuildContext context, int index) {
                return FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("items")
                        .where('itemID',
                            whereIn: cartMethods.separateOrderItemIDs({
                              snapshot.data.docs[index].data()
                                  as Map<String, dynamic>
                            })["productIDs"])
                        .where("orderBy",
                            whereIn: (snapshot.data.docs[index].data()
                                as Map<String, dynamic>)["uid"])
                        .orderBy("publishedDate", descending: true)
                        .get(),
                    builder: (context, ItemSnapshot) {
                      return Container();
                    });
              },
            );
          } else {
            return Center(
              child: Text(
                "No Order has been placed",
                style: TextStyle(fontSize: 18),
              ),
            );
          }
        },
      ),
    );
  }
}
