import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/network/utils.dart';
import '../models/cart_model.dart';
import '../repository/cart_repositary.dart';
import '../res/widgets/app_urls.dart';
import '../utils/utils.dart';
import '../viewModel/user_view_model.dart';
import 'new_home_screen.dart';
class MyExersice extends StatefulWidget {
  final String calories;
  const MyExersice({super.key, required this.calories, });

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<MyExersice> {
  final CartService _cartService = CartService();
  List<CartItem> _cartItems = [];
  double price=0.0;
  double calories=0;
  List foodOrder=[];
  List myOrders = [];
  @override
  void initState() {
    super.initState();
    getCategoriesData();
  }
  getCategoriesData() async {
    final userViewModel = UserViewModel();

    final user = await userViewModel.getUser();
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var data = {
      'user_id': localStorage.getString('user_id'),
    };

    var res = await Network().postData(data, '${AppUrls.baseUrl}/api/AllExersices');
    print(res.body);



    setState(()  {

    });


    if (json.decode(res.body)['exersice'] != null) {

      myOrders=json.decode(res.body)['exersice'];

    } else {

    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,


        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Exersice details',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Icon(Icons.tune, color: Colors.grey),
                ],
              ),
            ),
            Expanded(
              child: myOrders.isEmpty
                  ? Center(child: Text('Cart is empty!'))
                  : ListView.builder(
                itemCount: myOrders.length,
                itemBuilder: (context, index) {
                  final item = myOrders[index];
                  return OrderItemWidget(
                    imageUrl: item['image'],
                    name:  item['exerciser_name'],
                    price: item['exerciser_name'], calorie: item['description'],
                  );
                },
              ),),
            // List of items
            // Expanded(
            //   child: ListView(
            //     children: [
            //       OrderItemWidget(
            //         imageUrl: 'assets/pizza.png',
            //         name: 'Pizza pepperoni',
            //         price: 25.90,
            //       ),
            //       OrderItemWidget(
            //         imageUrl: 'assets/sushi.png',
            //         name: 'Philadelphia roll',
            //         price: 8.98,
            //       ),
            //       OrderItemWidget(
            //         imageUrl: 'assets/noodle.png',
            //         name: 'Noodle',
            //         price: 10.00,
            //       ),
            //     ],
            //   ),
            // ),

            // Place Order Button

          ],
        ),
      ),
    );
  }
}

class OrderItemWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String calorie;
  final String price;

  OrderItemWidget({
    required this.imageUrl,
    required this.name,
    required this.price, required this.calorie,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Item Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              AppUrls.ExersiceImages+imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16),

          // Item Name and Price
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'AUD ${price}',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  calorie,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),


              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isDiscount;
  final bool isTotal;

  SummaryRow({
    required this.title,
    required this.value,
    this.isDiscount = false,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isDiscount ? Colors.green : Colors.black,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isDiscount ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}






// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../models/cart_model.dart';
// import '../repository/cart_repositary.dart';
//
// class CartScreen extends StatefulWidget {
//   @override
//   _CartScreenState createState() => _CartScreenState();
// }
//
// class _CartScreenState extends State<CartScreen> {
//   final CartService _cartService = CartService();
//   List<CartItem> _cartItems = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _loadCartItems();
//   }
//
//   Future<void> _loadCartItems() async {
//     final items = await _cartService.getCartItems();
//     setState(() {
//       _cartItems = items;
//     });
//   }
//
//   Future<void> _addItem() async {
//     final newItem = CartItem(
//       id: DateTime.now().toString(),
//       name: 'Product ${_cartItems.length + 1}',
//       quantity: 1,
//       price: 20.0,
//       calorie: '150', // Example calorie value as String
//     );
//     await _cartService.addToCart(newItem);
//     _loadCartItems();
//   }
//
//   Future<void> _removeItem(String id) async {
//     await _cartService.removeFromCart(id);
//     _loadCartItems();
//   }
//
//   Future<void> _clearCart() async {
//     await _cartService.clearCart();
//     _loadCartItems();
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.delete),
//             onPressed: _clearCart,
//           ),
//         ],
//       ),
//       body: _cartItems.isEmpty
//           ? Center(child: Text('Cart is empty!'))
//           : ListView.builder(
//         itemCount: _cartItems.length,
//         itemBuilder: (context, index) {
//           final item = _cartItems[index];
//           return ListTile(
//             title: Text(item.name),
//             subtitle: Text('Quantity: ${item.quantity} ${item.calorie}'),
//             trailing: IconButton(
//               icon: Icon(Icons.remove_circle),
//               onPressed: () => _removeItem(item.id),
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: _addItem,
//       ),
//     );
//   }
// }
