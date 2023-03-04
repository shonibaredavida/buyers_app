import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:trial/global/global.dart';
import 'package:trial/history/history_screen.dart';
import 'package:trial/not_yet_received_parcels_screen/not_yet_received_parcels_screen.dart';
import 'package:trial/orders_screen/orders_screen.dart';
import 'package:trial/search_screen/search_screen.dart';
import 'package:trial/sellersScreens/home_screen.dart';
import 'package:trial/splashScreen/my_splash_screen.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black54,
      child: ListView(
        children: [
          //header
          Container(
            padding: const EdgeInsets.only(
              top: 26,
              bottom: 12,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 130,
                  width: 130,
                  child: CircleAvatar(
                    radius: 65,
                    foregroundImage:
                        NetworkImage(sharedPreferences!.getString("photoUrl")!),
                  ),
                ),
                sizedBox(height: 12),
                Text(
                  sharedPreferences!.getString("name")!.toTitleCase(),
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                sizedBox(height: 12)
              ],
            ),
          ), //body
          Container(
            padding: const EdgeInsets.only(top: 1),
            child: Column(
              children: [
                const Divider(height: 10, thickness: 2, color: Colors.grey),

                //Home
                ListTile(
                    leading: const Icon(Icons.home, color: Colors.grey),
                    title: const Text("Home",
                        style: TextStyle(
                          color: Colors.grey,
                        )),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                    }),

                //My Orders
                const Divider(height: 10, thickness: 2, color: Colors.grey),
                ListTile(
                    leading: const Icon(Icons.reorder, color: Colors.grey),
                    title: const Text("My Orders",
                        style: TextStyle(
                          color: Colors.grey,
                        )),
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const OrdersScreen()));
                    }),
                //Not Yet Received
                const Divider(height: 10, thickness: 2, color: Colors.grey),
                ListTile(
                    leading: const Icon(Icons.picture_in_picture_alt_rounded,
                        color: Colors.grey),
                    title: const Text("Not Yet Received",
                        style: TextStyle(
                          color: Colors.grey,
                        )),
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              const NotYetReceivedParcelScreen()));
                    }),

                //History
                const Divider(height: 10, thickness: 2, color: Colors.grey),
                ListTile(
                    leading: const Icon(Icons.access_time, color: Colors.grey),
                    title: const Text("History",
                        style: TextStyle(
                          color: Colors.grey,
                        )),
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const HistoryScreen()));
                    }),

                //Search
                const Divider(height: 10, thickness: 2, color: Colors.grey),
                ListTile(
                    leading: const Icon(Icons.search, color: Colors.grey),
                    title: const Text("Search",
                        style: TextStyle(
                          color: Colors.grey,
                        )),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SearchScreen()));
                    }),

                //LogOut
                const Divider(height: 10, thickness: 2, color: Colors.grey),
                ListTile(
                    leading: const Icon(Icons.exit_to_app, color: Colors.grey),
                    title: const Text("Logout",
                        style: TextStyle(
                          color: Colors.grey,
                        )),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MySplashScreen()));
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
