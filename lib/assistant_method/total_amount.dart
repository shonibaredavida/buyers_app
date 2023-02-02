import 'dart:async';

import 'package:flutter/material.dart';

class Totalamount extends ChangeNotifier {
  double totalamountOfCartItems = 0;
  double get tamount => totalamountOfCartItems;
  showTotalamountOfCartItems(double totalamount) async {
    totalamountOfCartItems = totalamount;
    await Future.delayed(const Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }
}
