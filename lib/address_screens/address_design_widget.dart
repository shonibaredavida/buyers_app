import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trial/assistant_method/address_changer.dart';
import 'package:trial/global/global.dart';
import 'package:trial/models/address_model.dart';
import 'package:trial/place_order_screens/place_order_screen.dart';

class AddressDesignWidget extends StatefulWidget {
  const AddressDesignWidget({
    super.key,
    this.index,
    this.model,
    this.addressID,
    this.sellerID,
    this.totalAmount,
    this.value,
  });
  final Address? model;
  final int? index;
  final int? value;
  final String? addressID;
  final String? totalAmount;
  final String? sellerID;
  @override
  State<AddressDesignWidget> createState() => _AddressDesignWidgetState();
}

class _AddressDesignWidgetState extends State<AddressDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white54,
      child: Column(
        children: [
          //address information
          Row(
            children: [
              Radio(
                value: widget.value,
                groupValue: widget.index,
                activeColor: Colors.pinkAccent,
                onChanged: (val) {
                  //provider
                  Provider.of<AddressChanger>(context, listen: false)
                      .showTheSelectedAddress(val);
                },
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Table(
                        children: [
                          TableRow(
                            children: [
                              const Text(
                                "Name",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(widget.model!.name.toString())
                            ],
                          ),
                          TableRow(children: [
                            sizedBox(height: 10),
                            sizedBox(height: 10)
                          ]),
                          TableRow(
                            children: [
                              const Text(
                                "Phone Number ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(widget.model!.phoneNumber.toString())
                            ],
                          ),
                          TableRow(children: [
                            sizedBox(height: 10),
                            sizedBox(height: 10)
                          ]),
                          TableRow(
                            children: [
                              const Text(
                                "Full Address",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(widget.model!.completeAddress.toString())
                            ],
                          ),
                          TableRow(children: [
                            sizedBox(height: 10),
                            sizedBox(height: 10)
                          ]),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),

          //button
          widget.value ==
                  Provider.of<AddressChanger>(context, listen: false).count
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ElevatedButton(
                    onPressed: () {
                      //send user to place order screen
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PlaceOrderScreen(
                              totalAmount: widget.totalAmount,
                              sellerUID: widget.sellerID,
                              addressID: widget.addressID)));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purpleAccent),
                    child: const Text("Proceed"),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
