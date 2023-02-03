import 'package:flutter/material.dart';
import 'package:trial/address_screens/save_new_address_screen.dart';

class AddressScreen extends StatefulWidget {
  AddressScreen({super.key, this.sellerUID, required this.totalAmount});
  String? sellerUID;
  double totalAmount;
  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
