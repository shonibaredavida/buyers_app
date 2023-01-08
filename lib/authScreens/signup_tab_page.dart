import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trial/widgets/custom_text_field.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;

class SignupTaPage extends StatefulWidget {
  @override
  State<SignupTaPage> createState() => _SignupTaPageState();
}

class _SignupTaPageState extends State<SignupTaPage> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String downloadUrlImage = "";
  XFile? imgXFile;
  final ImagePicker imagePicker = ImagePicker();
  getImageFromGallry() async {
    imgXFile = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imgXFile;
    });
  }

  formValidation() async {
    if (imgXFile == null) // no image selected
    {
      Fluttertoast.showToast(msg: "Pls Select an Image");
    } else {
      if (emailController.text.isNotEmpty &&
          namecontroller.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        // email n name, password, confirmatio n given
        //upload pix, get user info to firebase

        if (passwordController.text == confirmPasswordController.text) {
          // password n confirmation field are same
          String filename = DateTime.now().microsecondsSinceEpoch.toString();
          fStorage.Reference storageRef = fStorage.FirebaseStorage.instance
              .ref()
              .child("usersImage")
              .child(filename);
          fStorage.UploadTask uploadImageTask =
              storageRef.putFile(File(imgXFile!.path));
          fStorage.TaskSnapshot taskSnapshot =
              await uploadImageTask.whenComplete(() => null);
          await taskSnapshot.ref.getDownloadURL().then((urlImage) {
            downloadUrlImage = urlImage;
          });
        } else {
          // password n confirmation field are not match
          Fluttertoast.showToast(
              msg: "Password and Password Confirmaion do not match");
        }
      } else {
        //either email n name, password, confirmatio isnt given
        Fluttertoast.showToast(msg: "kindly complete the form");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      color: const Color.fromARGB(91, 167, 156, 156),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(height: 12),
          // get pix
          GestureDetector(
            onTap: (() {
              getImageFromGallry();
            }),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              radius: MediaQuery.of(context).size.width * 0.23,
              backgroundImage:
                  imgXFile == null ? null : FileImage(File(imgXFile!.path)),
              child: imgXFile == null
                  ? Icon(
                      Icons.add_photo_alternate,
                      color: Colors.white,
                      size: MediaQuery.of(context).size.width * 0.2,
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 12),
          //input Field
          Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextField(
                      namecontroller, Icons.person, false, true, "Name"),
                  CustomTextField(
                      emailController, Icons.email, false, true, "Email"),
                  CustomTextField(
                      passwordController, Icons.lock, true, true, "Password"),
                  CustomTextField(confirmPasswordController, Icons.lock, true,
                      true, "Confirm Password"),
                  const SizedBox(height: 20),
                ],
              )),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              padding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
            ),
            onPressed: () {
              formValidation();
            },
            child: const Text(
              "Signup",
              style: TextStyle(color: Colors.white),
            ),
          )
        ]),
      ),
    );
  }
}
