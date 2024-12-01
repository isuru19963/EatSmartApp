import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[100],
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
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
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  categoryItem('Deserts', 'assets/images/e1.png'),
                  categoryItem('Vegetarian', 'assets/images/e2.png'),
                  categoryItem('Meat', 'assets/images/e3.png'),
                  categoryItem('Fruits', 'assets/images/e4.png'),
                ],
              ),
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
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  foodCard(
                    'Cheese Burger',
                    'Cheesy Heaven',
                    '\$5.99',
                    '600 kcal',
                    Colors.blue,
                    'assets/images/b1.png',
                  ),
                  foodCard(
                    'Chicken Sandwich',
                    'Popeyes',
                    '\$3.59',
                    '800 kcal',
                    Colors.black,
                    'assets/images/b2.png',
                  ),
                ],
              ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                restaurantItem('McDonald\'s', '15 mins', 'assets/images/r2.png'),
                restaurantItem('Wendy\'s', '25 mins', 'assets/images/r1.png'),
              ],
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
              backgroundImage: AssetImage(imagePath),
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
              child: Image.asset(
                imagePath,
                height: 210,
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
                  Text(desc, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(price, style: const TextStyle(fontSize: 16)),
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
                      children: const [
                        Icon(Icons.shopping_cart, size: 16),
                        SizedBox(width: 5),
                        Text('ADD TO CART'),
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

  Widget restaurantItem(String name, String time, String imagePath) {
    return Column(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundImage: AssetImage(imagePath),
        ),
        const SizedBox(height: 5),
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(
          time,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }
}
