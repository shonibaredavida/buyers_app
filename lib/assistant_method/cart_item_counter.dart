import 'package:flutter/material.dart';
import 'package:trial/global/global.dart';

class CartItemCounter extends ChangeNotifier {
  int cartListItemCounter =
      sharedPreferences!.getStringList("userCart")!.length - 1;
  int get count => cartListItemCounter;

  Future<void> showCartListItemsNumber() async {
    cartListItemCounter =
        sharedPreferences!.getStringList("userCart")!.length - 1;
    Future.delayed(const Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }
}
