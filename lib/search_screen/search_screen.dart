import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trial/global/global.dart';
import 'package:trial/models/sellers.dart';
import 'package:trial/sellersScreens/sellers_ui_design_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? sellersEnteredText = "";
  Future<QuerySnapshot>? storesDocumentSnapshotList;
  initializedStoreSearch(sellerNameEntered) {
    storesDocumentSnapshotList = FirebaseFirestore.instance
        .collection('sellers')
        .where('name', isGreaterThanOrEqualTo: sellerNameEntered)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const MyDrawer(),
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: TextField(
          onChanged: (textEntered) {
            setState(() {
              sellersEnteredText = textEntered;
            });
            initializedStoreSearch(sellersEnteredText);
          },
          decoration: InputDecoration(
            hintStyle: const TextStyle(color: Colors.white54),
            hintText: "Search Sellers Name",
            suffixIcon: IconButton(
              onPressed: () {
                initializedStoreSearch(sellersEnteredText);
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: true,
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
      body: FutureBuilder(
          future: storesDocumentSnapshotList,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (sellersEnteredText == "") {
                return Center(
                  child: text("No Record found!"),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      Sellers model = Sellers.fromJson(snapshot.data.docs[index]
                          .data() as Map<String, dynamic>);
                      return SellersUiDesignWidget(
                        model: model,
                      );
                    });
              }
            } else {
              return Center(
                child: text("No Record found!"),
              );
            }
          }),
    );
  }
}
