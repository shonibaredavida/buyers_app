import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trial/global/global.dart';
import 'package:trial/orders_screen/status_banner_widget.dart';

class OrderDetailsScreen extends StatefulWidget {
  String? orderID;
  OrderDetailsScreen({this.orderID});
  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  String orderDataStatus = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("users")
                .doc(sharedPreferences!.getString("uid"))
                .collection("orders")
                .doc(widget.orderID.toString())
                .get(),
            builder: (c, AsyncSnapshot dataSnapshot) {
              if (dataSnapshot.hasData) {
                Map? orderDataMap =
                    dataSnapshot.data.data() as Map<String, dynamic>;
                orderDataStatus = orderDataMap['status'].toString();
                return Column(
                  children: [
                    StatusBanner(
                      orderStatus: orderDataStatus,
                      status: orderDataMap['isSucess'],
                    ),
                  ],
                );
              } else {
                return const Center(child: Text("No Details to display"));
              }
            }),
      ),
    );
  }
}
