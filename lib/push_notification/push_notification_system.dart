import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:trial/global/global.dart';

class PushNotifcationsSystem {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //3 possible scenarios when notification is received
  Future whenNotficationIsReceived() async {
    //1. terminated
    //when app is completely closed &PNS opens app..
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        // when open then show Notification data
      }
    });

    //2. foreground
    //when app is opened but its currently in used..
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        //show notificaton data immediately on app
      }
    });

    //3.  background (minimized)
    //when app is opened but its not currently in used..
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        //switches to the app and shows the notification
      }
    });
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
