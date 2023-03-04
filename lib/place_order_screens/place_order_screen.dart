import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trial/global/global.dart';
import 'package:trial/push_notification/push_notification_system.dart';
import 'package:trial/sellersScreens/home_screen.dart';

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
            sellerDeviceToken: sellerDeviceToken,
            orderId: orderId.toString(),
            notificationTitle: 'New Order',
            notificationBody:
                'Dear seller, New Order (# $orderId) successfully placed by ${sharedPreferences!.getString("name").toString()} \nPlease Check now');
      }
    });
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
