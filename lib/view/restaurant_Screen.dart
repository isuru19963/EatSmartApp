import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/network/utils.dart';
import '../models/cart_model.dart';
import '../repository/cart_repositary.dart';
import '../res/widgets/app_urls.dart';
import '../viewModel/user_view_model.dart';
import 'cart_screen.dart';
import 'food_detail_screen.dart';
class RestaurantScreen extends StatefulWidget {
  final String vendorId;
  final String name;
  final String description;
  const RestaurantScreen({super.key, required this.vendorId, required this.description, required this.name});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  List foods = [];
  final CartService _cartService = CartService();
  @override
  void initState() {
    getCategoriesData();
    super.initState();
  }
  getCategoriesData() async {
    final userViewModel = UserViewModel();

    final user = await userViewModel.getUser();
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var data = {
      'user_id': localStorage.getString('user_id'),
      'vendor_id': widget.vendorId,
    };

    var res = await Network().postData(data, '${AppUrls.baseUrl}/api/getAllFoodsByVendors');
    print(res.body);



    setState(()  {

    });


    if (json.decode(res.body)['foods'] != null) {

      foods=json.decode(res.body)['foods'];

    } else {

    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Section with Image and AppBar Icons
            Stack(
              children: [
                // Background Image
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/restaurant.png'), // Replace with your image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // AppBar Icons
                Positioned(
                  top: 40,
                  left: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.arrow_back, color: Colors.black),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 20,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.favorite_border, color: Colors.black),
                      ),
                      SizedBox(width: 10),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.share, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Restaurant Info Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.star, color: Colors.amber),
                      SizedBox(width: 4),
                      Text("4.8", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        "3 km",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    widget.description,
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        "Popular this week",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "See all",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Popular Food Cards
            Container(
                height: 350,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: foods.length,
                  itemBuilder: (context, index) {
                    final food = foods[index];
                    return GestureDetector(
                        onTap:(){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  FoodDetailsPage(image:  food['image'], id:  food['id'].toString(), description: food['description'], name: food['name'], price: food['price'],)),
                          );}
                        ,child:foodCard(
                      food['name'],
                      food['id'].toString(),
                      food['description'],
                      food['price'],
                      food['price'],

                      Colors.green,
                      food['image'],


                    ));
                  },
                )
            ),
          ],
        ),
      ),
    );
  }
  Widget foodCard(
      String name,
      String id,
      String desc,
      String price,
      String calories,
      Color buttonColor,
      String imagePath,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.network(
                AppUrls.FoodImages+imagePath,
                height: 200,
                width: 220,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(desc,
                      overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Aud $price', style: const TextStyle(fontSize: 16)),
                      Text(calories, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      // primary: buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        Icon(Icons.shopping_cart, size: 16),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () async {

                            final newItem = CartItem(
                              id: id,
                              name: name,
                              quantity: 1,
                              price: double.parse(price),
                              calorie: '150',
                              image: AppUrls.FoodImages+imagePath, // Example calorie value as String
                            );
                            await _cartService.addToCart(newItem);



                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  CartScreen()),
                            );

                          },
                          child:Text('ADD TO CART'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
