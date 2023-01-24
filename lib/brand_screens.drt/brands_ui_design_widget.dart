import 'package:flutter/material.dart';
import 'package:trial/brand_screens.drt/brands_screen.dart';
import 'package:trial/items_screen/items_screen.dart';
import 'package:trial/models/brands_model.dart';

class BrandsUIDesignWidget extends StatefulWidget {
  Brands? model;

  BrandsUIDesignWidget({this.model});
  @override
  State<BrandsUIDesignWidget> createState() => _BrandsUIDesignWidgetState();
}

class _BrandsUIDesignWidgetState extends State<BrandsUIDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // send the user to paticular brand items screen
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => ItemsScreen(model: widget.model)),
        );
      },
      child: Card(
        color: Colors.black,
        elevation: 10,
        shadowColor: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            height: 270,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.network(
                  widget.model!.thumbnailUrl.toString(),
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Text(
                widget.model!.brandTitle.toString(),
                style: const TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  letterSpacing: 3,
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
