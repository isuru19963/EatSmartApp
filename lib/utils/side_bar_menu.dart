import 'package:flutter/material.dart';
import 'package:mvvm_app/utils/routes/routes_names.dart';
import 'package:mvvm_app/view/cart_screen.dart';
import 'package:provider/provider.dart';

import '../view/my_orders.dart';
import '../viewModel/user_view_model.dart';

class SideMenuBar extends StatelessWidget {
  int _counter = 0;
  bool isOpened = false;

  @override
  Widget build(BuildContext context) {
    final preferences = Provider.of<UserViewModel>(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(left: 16.0),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: const [
          //       CircleAvatar(
          //         backgroundColor: Colors.white,
          //         radius: 22.0,
          //       ),
          //       SizedBox(height: 16.0),
          //       Text(
          //         "",
          //         style: TextStyle(color: Colors.white),
          //       ),
          //       SizedBox(height: 20.0),
          //     ],
          //   ),
          // ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  MyOrders()),
              );

            },
            leading: const Icon(Icons.home, size: 20.0, color: Colors.white),
            title: const Text("My Orders"),
            textColor: Colors.white,
            dense: true,
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  CartScreen()),
              );
            },
            leading:
            const Icon(Icons.add_chart, size: 20.0, color: Colors.white),
            title: const Text("Cart"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
    ListTile(
    onTap: () {

      preferences.removeUser().then((value) {
        Navigator.pop(context);
        Navigator.pushNamed(context, RouteNames.login);
      });

    },
    leading:
    const Icon(Icons.add_chart, size: 20.0, color: Colors.white),
    title: const Text("Log Out"),
    textColor: Colors.white,
    dense: true,

    // padding: EdgeInsets.zero,
    ),




        ],
      ),
    );
  }
}
