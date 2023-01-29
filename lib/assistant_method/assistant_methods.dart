import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trial/global/global.dart';

class CartMethods {
  addItemToCart({String? itemID, int? itemCounter, BuildContext? context}) {
    List<String>? tempList = sharedPreferences!.getStringList("userCart");
    tempList!.add("${itemID.toString()}: ${itemCounter.toString()}");

    //saving to firestore
    FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .update({"userCart": tempList})
        .then(
          (value) => Fluttertoast.showToast(msg: "Item added Successfully"),
        )
        .then((value) {
//update the badge number
        });
    if (dev) print("WE WE WE WE userCart updated on firebase");
    //adding the new item to local device
    sharedPreferences!.setStringList("userCart", tempList);
    if (dev) print("WE WE WE WE stored locally");
  }

  clearCart(BuildContext context) {
    //clear  cart local storage
    sharedPreferences!.setStringList("userCart", ['initialValue']);
    List<String>? emptyCart = sharedPreferences!.getStringList("userCart");
    FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid").toString())
        .update({
      "userCart": emptyCart,
    }).then((value) {
      //update badge numbers
    });
  }
}
