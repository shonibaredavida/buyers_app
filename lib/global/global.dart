import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trial/assistant_method/cart_methods.dart';

SharedPreferences? sharedPreferences;

CartMethods cartMethods = CartMethods();
final itemsImagesList = [
  "slider/0.jpg",
  "slider/1.jpg",
  "slider/2.jpg",
  "slider/3.jpg",
  "slider/4.jpg",
  "slider/5.jpg",
  "slider/6.jpg",
  "slider/7.jpg",
  "slider/8.jpg",
  "slider/9.jpg",
  "slider/10.jpg",
  "slider/11.jpg",
  "slider/12.jpg",
  "slider/13.jpg",
];

bool dev = true;

SizedBox sizedBox({double? height, double? width}) {
  return SizedBox(
    height: height ?? 1,
    width: width ?? 0,
  );
}

printo(message) {
  // ignore: avoid_print
  print("WE WE WE $message`");
}
