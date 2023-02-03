import 'package:flutter/material.dart';

class SaveNewAddressScreen extends StatefulWidget {
  SaveNewAddressScreen(
      {super.key, required this.sellerUID, required this.totalAmount});
  String sellerUID;
  double totalAmount;
  @override
  State<SaveNewAddressScreen> createState() => _SaveNewAddressScreenState();
}

class _SaveNewAddressScreenState extends State<SaveNewAddressScreen> {
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
          MaterialPageRoute(
            builder: (c) => SaveNewAddressScreen(
              sellerUID: widget.sellerUID.toString(),
              totalAmount: widget.totalAmount.toDouble(),
            ),
          );
        },
        label: const Text("Save Address"),
        icon: const Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
    );
  }
}
