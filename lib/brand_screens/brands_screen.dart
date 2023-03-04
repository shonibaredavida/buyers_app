import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:trial/brand_screens/brands_ui_design_widget.dart';
import 'package:trial/global/global.dart';
import 'package:trial/models/brands_model.dart';
import 'package:trial/models/sellers.dart';
import 'package:trial/widgets/my_drawer.dart';
import 'package:trial/widgets/text_delegate_header_widget.dart';

class BrandsScreen extends StatefulWidget {
  final Sellers? model;
  const BrandsScreen({super.key, this.model});
  @override
  State<BrandsScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: const MyDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          "widget",
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
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              pinned: true,
              delegate: TextDelegateHeaderWidget(
                  title: "${widget.model!.name.toString()} - Brands")),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .doc(widget.model!.uid.toString())
                .collection("brands")
                .orderBy("publishedDate", descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot dataSnapShot) {
              if (dataSnapShot.hasData) {
                if (dev) printo("brands exist");

//if there are brands
                return SliverStaggeredGrid.countBuilder(
                    crossAxisCount: 1,
                    staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                    itemBuilder: ((context, index) {
                      if (dev) printo("Streaming the exisiting brands ");
// this translate the firebase json stream to the model class
//to return a useable format for the ui design widget
                      Brands brandsModel = Brands.fromJson(
                          dataSnapShot.data.docs[index].data()
                              as Map<String, dynamic>);
                      return BrandsUIDesignWidget(
                        model: brandsModel,
                      );
                    }),
                    itemCount: dataSnapShot.data.docs.length);
              } else {
                if (dev) printo(" No Brands Added' ");

                //if there are no brands
                return const SliverToBoxAdapter(
                    child: Text(
                  'No Brands Added',
                  textAlign: TextAlign.center,
                ));
              }
            },
          ),
        ],
      ),
    );
  }
}
