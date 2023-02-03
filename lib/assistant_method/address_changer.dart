import 'package:flutter/material.dart';

class AddressChanger extends ChangeNotifier {
  int counter = 0;
  int get count => counter;
  showTheSelectedAddress(dynamic newValue) {
    counter = newValue;
    notifyListeners();
  }
}
