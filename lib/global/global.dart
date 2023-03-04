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
String fcmServerToken =
    'key= AAAA7OeAvQc:APA91bGUDjnyGwuOBNFWczUpYcR0tqhLq9trtxioecRfHHwSMTovlywZaUDaAseMjMdS4Tr3mTQjGFX2gg_vx-ckaBdNIbAuIc8bszwF7daA0ZSBKd7W1fdsgS1KdzkQX3CijOJZPg1T';

extension StringCasingExtension on String {
  String capitalize() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.capitalize())
      .join(' ');
}

double countStarsRating = 0.0;
String titleStarsRating = "";
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

Color appDeeperPrimaryColor = Colors.purpleAccent;

Widget text(String data,
    {Color? color,
    double? letterSpacing,
    double? fontSize,
    TextAlign? textAlign,
    FontWeight? fontWeight}) {
  return Text(
    data,
    textAlign: textAlign ?? TextAlign.start,
    style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? Colors.white,
        letterSpacing: letterSpacing ?? 2,
        fontSize: fontSize ?? 16),
  );
}
