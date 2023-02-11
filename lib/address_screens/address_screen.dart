import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trial/address_screens/address_design_widget.dart';
import 'package:trial/address_screens/save_new_address_screen.dart';
import 'package:trial/assistant_method/address_changer.dart';
import 'package:trial/global/global.dart';
import 'package:trial/models/address_model.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key, this.sellerUID, required this.totalAmount});
  final String? sellerUID;
  final double totalAmount;
  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
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
          // ignore: avoid_print
          dev ? print("WE WE WE navigation to savedNewaddressScreen ") : null;

          Navigator.of(context).push(MaterialPageRoute(
            builder: (c) => SaveNewAddressScreen(
              sellerUID: widget.sellerUID.toString(),
              totalAmount: widget.totalAmount.toDouble(),
            ),
          ));
        },
        label: const Text("Add New Address"),
        icon: const Icon(
          Icons.add_location,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Consumer<AddressChanger>(builder: (context, address, c) {
            return Flexible(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(sharedPreferences!.getString("uid"))
                    .collection("userAddress")
                    .snapshots(),
                builder: ((context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.docs.length > 0) {
                      return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AddressDesignWidget(
                            index: address.count,
                            model: Address.fromJson(snapshot.data.docs[index]
                                .data() as Map<String, dynamic>),
                            sellerID: widget.sellerUID,
                            totalAmount: widget.totalAmount.toString(),
                            addressID: snapshot.data.docs[index].id,
                            value: index,
                          );
                        },
                      );
                    } else {
                      return Container();
                    }
                  } else {
                    return const Center(child: Text("No Address Added"));
                  }
                }),
              ),
            );
          }),
        ],
      ),
    );
  }
}
