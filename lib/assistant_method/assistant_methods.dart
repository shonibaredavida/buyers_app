import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:trial/assistant_method/cart_item_counter.dart';
import 'package:trial/global/global.dart';

class CartMethods {
  addItemToCart(
      {String? itemID, int? itemCounter, required BuildContext context}) {
    List<String>? tempList = sharedPreferences!.getStringList("userCart");
    tempList!.add("${itemID.toString()}: ${itemCounter.toString()}");

    //saving to firestore
    FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .update({"userCart": tempList}).then(
      (value) => Fluttertoast.showToast(msg: "Item added Successfully"),
    );

//update the badge number
    Provider.of<CartItemCounter>(context, listen: false)
        .showCartListItemsNumber();

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
      Provider.of<CartItemCounter>(context, listen: false)
          .showCartListItemsNumber();
    });
  }

  separateItemIDsFromUserCartList() {
    List<String>? userCartList = sharedPreferences!.getStringList("userCart");
    List<String>? itemIDList = []; //cart will be [123443:4,2323443:1,12345:43]
    //  if (dev) print(userCartList);
    for (int i = 1; i < userCartList!.length; i++) {
      String item = userCartList[i]
          .toString(); //this will get items in the cart as 122334:4

      var getItemIDonly = item.split(':')[
          0]; //this will split the items n select everything b4 ":" i.e 122334
      itemIDList.add(getItemIDonly);
      /* 
      //another way
        var lastCaracterPositionOfItemBeforeColon = item.lastIndexOf(":");
      String getItemIdOnly =
          item.substring(0, lastCaracterPositionOfItemBeforeColon);
      itemIDList.add(getItemIdOnly); */
      //   if (dev) print("$itemIDList ...... $i");
    }

    return itemIDList;
  }

  separateItemQtyFromUserCartList() {
    List<String>? userCartList = sharedPreferences!.getStringList("userCart");
    List<int>? itemQtyList = []; //cart will be [123443:4,2323443:1,12345:43]
    if (dev) print(userCartList);
    for (int i = 1; i < userCartList!.length; i++) {
      String item = userCartList[i]
          .toString(); //this will get items in the cart as 122334:4

      // var getItemQtyonly = item.split(':')[ 1];
      // //this will split the items n select everything b4 ":" i.e 122334
      // itemQtyList.add(getItemQtyonly);

      //another way
      var lastCaracterPositionOfItemBeforeColon = item.lastIndexOf(":");
      int getItemQtyOnly =
          int.parse(item.substring(lastCaracterPositionOfItemBeforeColon + 1));

      itemQtyList.add(getItemQtyOnly);
      if (dev) print("$itemQtyList ...... $i");
    }

    return itemQtyList;
  }
}
