import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';
import 'package:trial/global/global.dart';
import 'package:trial/splashScreen/my_splash_screen.dart';

class RateSellerScreen extends StatefulWidget {
  const RateSellerScreen({super.key, required this.sellerID});
  final String? sellerID;

  @override
  State<RateSellerScreen> createState() => _RateSellerScreenState();
}

class _RateSellerScreenState extends State<RateSellerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Dialog(
        backgroundColor: Colors.white60,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          margin: const EdgeInsets.all(0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text(
              "Rate ths Seller",
              style: TextStyle(
                fontSize: 22,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            sizedBox(height: 22),
            const Divider(
              height: 4,
              thickness: 4,
            ),
            sizedBox(height: 22),
            SmoothStarRating(
              rating: countStarsRating,
              allowHalfRating: true,
              starCount: 5,
              color: Colors.purpleAccent,
              borderColor: Colors.purpleAccent,
              size: 46,
              onRatingChanged: (ratingValue) {
                countStarsRating = ratingValue;
                if (countStarsRating == 1) {
                  setState(() {
                    titleStarsRating = "Very Bad";
                  });
                } else if (countStarsRating == 2) {
                  setState(() {
                    titleStarsRating = "Bad";
                  });
                } else if (countStarsRating == 3) {
                  setState(() {
                    titleStarsRating = "Good";
                  });
                } else if (countStarsRating == 4) {
                  setState(() {
                    titleStarsRating = "Very Good";
                  });
                } else if (countStarsRating == 5) {
                  setState(() {
                    titleStarsRating = "Excellent ";
                  });
                }
              },
            ),
            sizedBox(height: 12),
            Text(
              titleStarsRating,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.purpleAccent,
              ),
            ),
            sizedBox(
              height: 18,
            ),
            ElevatedButton(
                onPressed: () {
                  if (dev) {
                    printo("retreiving current seller ratings");
                  }
                  FirebaseFirestore.instance
                      .collection("sellers")
                      .doc(widget.sellerID)
                      .get()
                      .then((sellerSnap) {
                    if (sellerSnap.data()!['ratings'] == null) {
                      if (dev) {
                        printo("seller has no rating");
                      }
                      //seller isnt rated by any user
                      FirebaseFirestore.instance
                          .collection("sellers")
                          .doc(widget.sellerID)
                          .update({"ratings": countStarsRating.toString()});
                    } else {
                      //seller has been rated by atleast a user
                      double previousRating =
                          double.parse(sellerSnap.data()!['ratings']);
                      if (dev) {
                        printo("seller has rating: $previousRating ");
                      }
                      double newSellerRating =
                          (previousRating + countStarsRating) / 2;
                      FirebaseFirestore.instance
                          .collection("sellers")
                          .doc(widget.sellerID)
                          .update({
                        "ratings": newSellerRating.toString()
                      }).whenComplete(() {
                        if (dev) {
                          printo("sending a toast to the user");
                        }
                        Fluttertoast.showToast(msg: "Seller Rated Succesfully");
                        setState(() {
                          titleStarsRating = "";
                          countStarsRating = 0.0;
                        });
                        if (dev) {
                          printo(
                              "resetting app star rating info. & navigating to splash screen");
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MySplashScreen()));
                      });
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 74, vertical: 5)),
                child: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                )),
            sizedBox(
              height: 18,
            ),
          ]),
        ),
      ),
    );
  }
}
