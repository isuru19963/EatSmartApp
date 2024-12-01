import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mvvm_app/view/restaurant_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import '../data/network/utils.dart';
import '../models/cart_model.dart';
import '../repository/cart_repositary.dart';
import '../res/widgets/app_urls.dart';
import '../utils/side_bar_menu.dart';
import '../viewModel/home_view_model.dart';
import '../viewModel/user_view_model.dart';
import 'cart_screen.dart';
import 'food_detail_screen.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomePage> {
  bool isOpened = false;
  final CartService _cartService = CartService();
  List<CartItem> _cartItems = [];
  HomeViewModel hm = HomeViewModel();
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final GlobalKey<SideMenuState> _endSideMenuKey = GlobalKey<SideMenuState>();
  List categories = [];
  List foods = [];
  List vendors = [];
  @override
  void initState() {
    hm.fetchMoviesListApi();
    getCategoriesData();
    getProductsData();
    getVendorsData();
    super.initState();
  }
  getCategoriesData() async {
    final userViewModel = UserViewModel();

    final user = await userViewModel.getUser();
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var data = {
      'user_id': localStorage.getString('user_id'),
    };

    var res = await Network().postData(data, '${AppUrls.baseUrl}/api/getAllCategories');
    print(res.body);



    setState(()  {

    });


    if (json.decode(res.body)['categories'] != null) {

      categories=json.decode(res.body)['categories'];

    } else {

    }


  }

  getProductsData() async {
    final userViewModel = UserViewModel();

    final user = await userViewModel.getUser();
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var data = {
      'user_id': localStorage.getString('user_id'),
    };

    var res = await Network().postData(data, '${AppUrls.baseUrl}/api/getAllFoods');
    print(res.body);



    setState(()  {

    });


    if (json.decode(res.body)['foods'] != null) {

      foods=json.decode(res.body)['foods'];

    } else {

    }


  }
  getVendorsData() async {
    final userViewModel = UserViewModel();

    final user = await userViewModel.getUser();
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var data = {
      'user_id': localStorage.getString('user_id'),
    };

    var res = await Network().postData(data, '${AppUrls.baseUrl}/api/getAllVendros');
    print(res.body);



    setState(()  {

    });


    if (json.decode(res.body)['vendors'] != null) {

      vendors=json.decode(res.body)['vendors'];

    } else {

    }


  }
  toggleMenu([bool end = false]) {
    if (end) {
      final _state = _endSideMenuKey.currentState!;
      if (_state.isOpened) {
        _state.closeSideMenu();
      } else {
        _state.openSideMenu();
      }
    } else {
      final _state = _sideMenuKey.currentState!;
      if (_state.isOpened) {
        _state.closeSideMenu();
      } else {
        _state.openSideMenu();
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return SideMenu(
        background: Color(0xff276A6E),
    key: _sideMenuKey,
    menu: SideMenuBar(),
    type: SideMenuType.slideNRotate,
    onChange: (_isOpened) {
    setState(() => isOpened = _isOpened);
    },
    child: IgnorePointer(
    ignoring: isOpened,
    child:Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[100],
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.menu,color: Colors.black,),
          onPressed: () {
            if (isOpened) {
              Navigator.pop(context);
            } else {
              toggleMenu();
            }
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 10),
                    const Text(
                      'Search...',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.tune, color: Colors.grey),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Categories Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return categoryItem(category['name']!, category['image']!);
                },
              )
            ),

            const SizedBox(height: 20),

            // Popular This Week Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Popular this week',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
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
                    food['calorie'],

                    Colors.green,
                    food['image'],


                  ));
                },
              )
            ),

            const SizedBox(height: 20),

            // Pizza Offer Banner
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 190,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),

                  image: const DecorationImage(
                    image: AssetImage('assets/images/rect1.png'), // Replace with your asset
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Text(
                    '',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Popular Restaurants Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Popular Restaurants',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),

            Container(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: vendors.length,
                  itemBuilder: (context, index) {
                    final category = vendors[index];
                    return restaurantItem(category['name']!, '15 mins', category['vendor_image']!,category['id'].toString()!,category['occupation']!);
                  },
                )
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: '',
          ),
        ],
      ),
    ),
    )
    );
  }

  Widget categoryItem(String title, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            color: Colors.white,

          ),
        child:Column(
          children: [
        Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
        child:CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(AppUrls.categoryImages+imagePath),
            ),),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5),
          ],
        ),
      )
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
                      Text('$calories kcal', style: const TextStyle(color: Colors.grey)),
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
                              calorie: calories,
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

  Widget restaurantItem(String name, String time, String imagePath, String vendorId, String description) {
    return GestureDetector(
    onTap: (){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  RestaurantScreen(vendorId: vendorId.toString(), description: description, name: name,)),
      );

    },
      child:
    Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
    child: Column(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundImage: NetworkImage( AppUrls.VendorImages+imagePath,),
        ),
        const SizedBox(height: 5),
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(
          time,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    )));
  }
}
