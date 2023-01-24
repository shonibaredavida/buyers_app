import 'package:flutter/material.dart';
import 'package:trial/global/global.dart';
import 'package:trial/items_screen/item_details_screen.dart';
import 'package:trial/models/items_models.dart';

class ItemsUIDesignWidget extends StatefulWidget {
  Items? model;
  ItemsUIDesignWidget({this.model});
  @override
  State<ItemsUIDesignWidget> createState() => _ItemsUIDesignWidgetState();
}

class _ItemsUIDesignWidgetState extends State<ItemsUIDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ItemsDetailsScreen(
                      model: widget.model,
                    )));
      },
      child: Card(
        elevation: 10,
        shadowColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            height: 270,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              sizedBox(),
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  widget.model!.thumbnailUrl.toString(),
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
              sizedBox(),
              Text(
                widget.model!.itemTitle.toString(),
                style: const TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  letterSpacing: 3,
                ),
              ),
              sizedBox(),
              Text(
                widget.model!.itemInfo.toString(),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
