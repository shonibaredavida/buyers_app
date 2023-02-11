import 'package:flutter/material.dart';
import 'package:trial/global/global.dart';
import 'package:trial/models/items_models.dart';

class CartItemDesign extends StatefulWidget {
  const CartItemDesign({super.key, this.model, this.qty});
  final Items? model;
  final int? qty;
  @override
  State<CartItemDesign> createState() => _CartItemDesignState();
}

class _CartItemDesignState extends State<CartItemDesign> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Card(
        shadowColor: Colors.white54,
        color: Colors.black,
        elevation: 10,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: Row(children: [
            //image
            Image.network(
              widget.model!.thumbnailUrl.toString(),
              width: 140,
              height: 120,
              fit: BoxFit.contain,
            ),
            sizedBox(
              width: 4,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title
                  Text(
                    widget.model!.itemTitle.toString(),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  sizedBox(height: 4),
                  //Price : N1200
                  Row(
                    children: [
                      const Text(
                        "Price: ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "x ${widget.model!.price.toString()} ",
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  sizedBox(height: 4),
                  //Quantity: x 4
                  Row(
                    children: [
                      const Text(
                        "Quantity: ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                      /*   const Text(
                        "x ",
                        style: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 15,
                        ),
                      ), */
                      Text(
                        widget.qty!.toString(),
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  /* Row(
                    children: [
                      const Text(
                        "Price: ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "N ${widget.model!.price.toString()}",
                        style: const TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        " x ${widget.qty.toString()} ",
                        style: const TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ), */
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
