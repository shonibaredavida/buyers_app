import 'package:flutter/material.dart';
import 'package:trial/global/global.dart';
import 'package:trial/splashScreen/my_splash_screen.dart';
import 'package:trial/widgets/appbar_cart_badget.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key, this.sellerUID});
  String? sellerUID;
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithCartBadge(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          sizedBox(height: 10),
          FloatingActionButton.extended(
            onPressed: () {
              cartMethods.clearCart(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => const MySplashScreen()));
            },
            heroTag: "btn1",
            label: const Text(
              "Clear Cart",
              style: TextStyle(fontSize: 16),
            ),
            icon: const Icon(Icons.clear_all),
          ),
          FloatingActionButton.extended(
            onPressed: () {},
            heroTag: "btn2",
            label: const Text(
              "Check Out",
              style: TextStyle(fontSize: 16),
            ),
            icon: const Icon(Icons.navigate_next),
          ),
        ],
      ),
      body: null,
    );
  }
}
