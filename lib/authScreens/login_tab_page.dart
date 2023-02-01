import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trial/global/global.dart';
import 'package:trial/splashScreen/my_splash_screen.dart';
import 'package:trial/widgets/custom_text_field.dart';
import 'package:trial/widgets/loading_dialog.dart';

class LoginTabPage extends StatefulWidget {
  const LoginTabPage({super.key});

  @override
  State<LoginTabPage> createState() => _LoginTabPageState();
}

class _LoginTabPageState extends State<LoginTabPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  validateForm() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      loginnow();
    } else if (emailController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Kindly enter your email");
    } else if (passwordController.text.isEmpty) {
      Fluttertoast.showToast(msg: "KIindly enter your password");
    } else {
      Fluttertoast.showToast(
          msg: "KIndly enter your email and password details");
    }
  }

  loginnow() async {
    User? currentUser;
    showDialog(
        context: context,
        builder: (c) => const LoadingDialogWidget(
              message: "Checking your credentials ",
            ));

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim())
        .then((auth) => currentUser = auth.user)
        .catchError((errorMessage) {
      Fluttertoast.showToast(msg: "Error occured \n $errorMessage");
      Navigator.of(context).pop();
    });
    if (currentUser != null) {
      checkIfUserRecordExist(currentUser);
    }
  }

  checkIfUserRecordExist(currentUser) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .get()
        .then((record) async {
      if (record.exists) {
        //user record exist
        if (record.data()!["status"] == "approved") {
          //user record is approved to login in
          await sharedPreferences!.setString("uid", record.data()!["uid"]);
          await sharedPreferences!.setString("email", record.data()!["email"]);
          await sharedPreferences!.setString("name", record.data()!["name"]);
          List<String> userCartList = record.data()!["userCart"].cast<String>();
          await sharedPreferences!
              .setString("photoUrl", record.data()!["photoUrl"]);
          await sharedPreferences!.setStringList("userCart", userCartList);

          //send the user to home screen
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MySplashScreen()));
        } else {
          //user have been BLOCKED by Admin \n contact amin@weshop.com
          FirebaseAuth.instance.signOut();
          Navigator.of(context).pop();
          Fluttertoast.showToast(
              msg: "You have been BLOCKED by Admin \n contact amin@weshop.com");
        }
      } else {
        //user record doesnt exist
        FirebaseAuth.instance.signOut();
        Navigator.of(context).pop();
        Fluttertoast.showToast(msg: "This User doesnt exist, Pls Signup ");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      color: const Color.fromARGB(91, 167, 156, 156),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.20,
              child: Image.asset("images/login.png"),
            ),
            const SizedBox(height: 30),
            Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(
                      emailController, Icons.email, false, true, "Email"),
                  CustomTextField(
                      passwordController, Icons.lock, true, true, "Password"),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
              ),
              onPressed: () {
                validateForm();
              },
              child: const Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
