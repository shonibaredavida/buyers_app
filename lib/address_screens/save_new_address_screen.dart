import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trial/address_screens/text_field_address_widget.dart';
import 'package:trial/global/global.dart';

class SaveNewAddressScreen extends StatefulWidget {
  const SaveNewAddressScreen(
      {super.key, required this.sellerUID, required this.totalAmount});
  final String sellerUID;
  final double totalAmount;
  @override
  State<SaveNewAddressScreen> createState() => _SaveNewAddressScreenState();
}

class _SaveNewAddressScreenState extends State<SaveNewAddressScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController flatHouseNumber = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController stateCountry = TextEditingController();
  TextEditingController streetNumber = TextEditingController();
  String completeAddress = "";
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "iShop",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.green,
                  Colors.black,
                  Colors.red,
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                // stops: [0.0, 1.0],  #check
                tileMode: TileMode.clamp),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            completeAddress =
                "${streetNumber.text.trim()}, ${flatHouseNumber.text.trim()}, ${city.text.trim().toTitleCase()}, ${stateCountry.text.trim().toTitleCase()} ";

            dev ? printo("saving address to firestore") : null;
            FirebaseFirestore.instance
                .collection("users")
                .doc(sharedPreferences!.getString("uid"))
                .collection("userAddress")
                .doc(DateTime.now().millisecondsSinceEpoch.toString())
                .set({
              "name": name.text.trim().toTitleCase(),
              "phoneNumber": phoneNumber.text.trim(),
              "flatHouseNumber": flatHouseNumber.text.trim(),
              "city": city.text.trim().toTitleCase(),
              "streetNumber": streetNumber.text.trim(),
              "stateCountry": stateCountry.text.trim().toTitleCase(),
              "completeAddress": completeAddress,
            }).then((value) {
              Fluttertoast.showToast(msg: "New Shipment Address Saved");
              formKey.currentState!.reset();
            });
          }
        },
        label: const Text("Save Address"),
        icon: const Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: Center(
                child: Text(
                  "Save New Address",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFieldAddressWidget(
                      controller: name,
                      hint: "Name",
                    ),
                    TextFieldAddressWidget(
                      controller: phoneNumber,
                      hint: "Phone Number",
                    ),
                    TextFieldAddressWidget(
                      controller: streetNumber,
                      hint: "Street Number",
                    ),
                    TextFieldAddressWidget(
                      controller: flatHouseNumber,
                      hint: "flat/ house number",
                    ),
                    TextFieldAddressWidget(
                      controller: city,
                      hint: "City ",
                    ),
                    TextFieldAddressWidget(
                      controller: stateCountry,
                      hint: "State / Country",
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
