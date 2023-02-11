import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:trial/global/global.dart';
import 'package:trial/items_screen/item_ui_design.dart';
import 'package:trial/models/brands_model.dart';
import 'package:trial/models/items_models.dart';
import 'package:trial/widgets/text_delegate_header_widget.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({super.key, this.model});
  final Brands? model;
  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: TextDelegateHeaderWidget(
                title: " ${widget.model!.brandTitle.toString()}'s Items"),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .doc(widget.model!.sellerUID.toString())
                .collection("brands")
                .doc(widget.model!.brandID.toString())
                .collection('items')
                .orderBy("publishedDate", descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot dataSnapShot) {
              if (dataSnapShot.hasData) {
//if there are brands
                if (dev) printo(" getting brands");
                return SliverStaggeredGrid.countBuilder(
                    crossAxisCount: 1,
                    staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                    itemBuilder: ((context, index) {
                      Items itemsModel = Items.fromJson(
                          dataSnapShot.data.docs[index].data()
                              as Map<String, dynamic>);
                      return ItemsUIDesignWidget(
                        model: itemsModel,
                      );
                    }),
                    itemCount: dataSnapShot.data.docs.length);
              } else {
                if (dev) printo(" No brand available");
                //if there are no brands
                return const SliverToBoxAdapter(
                    child: Text(
                  'No Items Added',
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
