import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';
import 'package:trial/models/sellers.dart';

class SellersUiDesignWidget extends StatefulWidget {
  Sellers? model;
  SellersUiDesignWidget({this.model});

  @override
  State<SellersUiDesignWidget> createState() => _SellersUiDesignWidgetState();
}

class _SellersUiDesignWidgetState extends State<SellersUiDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.black54,
        elevation: 20,
        shadowColor: Colors.grey,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.network(
                widget.model!.photoUrl.toString(),
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 1,
            ),
            Text(
              widget.model!.name.toString(),
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent),
            ),
            SmoothStarRating(
              rating: widget.model!.ratings == null
                  ? 0.0
                  : double.parse(widget.model!.ratings.toString()),
              starCount: 5,
              color: Colors.pinkAccent,
              borderColor: Colors.pinkAccent,
              size: 16,
            )
          ],
        ),
      ),
    );
  }
}
