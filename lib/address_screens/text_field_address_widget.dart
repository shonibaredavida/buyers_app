import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFieldAddressWidget extends StatelessWidget {
  TextFieldAddressWidget({super.key, this.controller, this.hint});
  final String? hint;
  TextEditingController? controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration.collapsed(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
        ),
        validator: (value) => value!.isEmpty ? "Field cannot be empty" : null,
      ),
    );
  }
}
