import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:trial/functions/functions.dart';
import 'package:trial/global/global.dart';

class PushNotifcationsSystem {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //3 possible scenarios when notification is received
  Future whenNotficationIsReceived(context) async {
    //1. terminated
    //when app is completely closed &PNS opens app..
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        showNotificationWhenOpenApp(remoteMessage.data['orderId'], context);
        // when open then show Notification data
      }
    });

    //2. foreground
    //when app is opened but its currently in used..
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        //show notificaton data immediately on appz
        showNotificationWhenOpenApp(remoteMessage.data['orderId'], context);
      }
    });

    //3.  background (minimized)
    //when app is opened but its not currently in used..
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        //switches to the app and shows the notification
        showNotificationWhenOpenApp(remoteMessage.data['orderId'], context);
      }
    });
  }

  //device recognition token
  showNotificationWhenOpenApp(orderId, context) {
    showReusableSnackBar(
        "Your Order # $orderId\n\n has been shifted to the nearest pick up center",
        context);
  }

  //device recognition token
  Future generateDeviceRecognitionToken() async {
    String? registrationDeviceToken = await messaging.getToken();
    FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .update({"userDeviceToken": registrationDeviceToken}).whenComplete(() {
      if (dev) printo("User token $registrationDeviceToken");
    });
    messaging.subscribeToTopic("allSellers");
    messaging.subscribeToTopic("allUsers");
  }
}

notificationFormat(
    {required String sellerDeviceToken,
    required String orderId,
    required String notificationBody,
    required notificationTitle}) {
  Map<String, String> hearderNotification = {
    'Content-Type': 'application/json',
    'Authorization': fcmServerToken
  };

  Map bodyNotification = {'body': notificationBody, 'title': notificationTitle};
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
