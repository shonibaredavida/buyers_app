import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trial/global/global.dart';
import 'package:trial/sellersScreens/home_screen.dart';
import 'package:http/http.dart' as http;

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({
    super.key,
    this.addressID,
    this.sellerUID,
    this.totalAmount,
  });
  final String? addressID;
  final String? totalAmount;
  final String? sellerUID;
  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  String orderId = DateTime.now().millisecondsSinceEpoch.toString();

  sendNotifcationToSeller(String? sellerUID, String? orderId) async {
    await FirebaseFirestore.instance
        .collection("sellers")
        .doc(sellerUID)
        .get()
        .then((snapshot) {
      if (snapshot.data()!['sellerDeviceToken'] != null) {
        String? sellerDeviceToken =
            snapshot.data()!['sellerDeviceToken'].toString();
        if (dev) printo("FCM Seller device token: $sellerDeviceToken");
        if (dev) printo("FCM OderId: $orderId");
        notificationFormat(
            sellerDeviceToken, orderId, sharedPreferences!.getString("name"));
      }
    });
  }

  notificationFormat(String sellerDeviceToken, String? orderId, String? name) {
    Map<String, String> hearderNotification = {
      'Content-Type': 'application/json',
      'Authorization': fcmServerToken
    };

    Map bodyNotification = {
      'body':
          'Dear seller, New Order (# $orderId) successfully placed by $name \nPlease Check now',
      'title': 'New Order'
    };
    Map dataMap = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      "status": 'done',
      'userOrderId': orderId,
    };
    Map officialNotificationFormat = {
      'notification': bodyNotification,
      'data': dataMap,
      'priority': 'high',
      'to': sellerDeviceToken,
    };
    http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: hearderNotification,
        body: jsonEncode(officialNotificationFormat));
  }

  orderDetails() {
    saveOrderDetailsForUser({
      "addressID": widget.addressID,
      "totalAmount": widget.totalAmount,
      "orderBy": sharedPreferences!.getString("uid"),
      "productIDs": sharedPreferences!.getStringList("userCart"),
      "orderId": orderId,
      "orderTime": orderId,
      "isSucess": true,
      "sellerUID": widget.sellerUID,
      "status": "normal",
    }).whenComplete(() {
      saveOrderDetailsForSeller({
        "addressID": widget.addressID,
        "totalAmount": widget.totalAmount,
        "orderBy": sharedPreferences!.getString("uid"),
        "productIDs": sharedPreferences!.getStringList("userCart"),
        "orderId": orderId,
        "sellerUID": widget.sellerUID,
        "orderTime": orderId,
        "isSucess": true,
        "status": "normal",
      }).whenComplete(() {
        cartMethods.clearCart(context);

        //Implement send push Notification
        sendNotifcationToSeller(widget.sellerUID, orderId);

        Fluttertoast.showToast(
            msg: "Congratulations, Your Order has been placed successfully");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
        orderId = "";
      });
    });
    saveOrderDetailsForSeller({
      "addressID": widget.addressID,
      "totalAmount": widget.totalAmount,
      "sellerID": widget.sellerUID,
    });
  }

  saveOrderDetailsForUser(Map<String, dynamic> orderDetailsMap) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection("orders")
        .doc(orderId)
        .set(orderDetailsMap);
  }

  saveOrderDetailsForSeller(Map<String, dynamic> orderDetailsMap) async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(orderId)
        .set(orderDetailsMap);
  }

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
            onPressed: () {
              orderDetails();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text("Place Order Now"),
          )
        ],
      ),
    );
  }
}
