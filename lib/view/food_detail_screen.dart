import 'dart:convert';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/cart_model.dart';
import '../repository/cart_repositary.dart';
import '../repository/nutriton.dart';
import '../res/widgets/app_urls.dart';
import 'cart_screen.dart';
class FoodDetailsPage extends StatefulWidget {
  final String image;
  final String id;
  final String description;
  final String name;
  final String price;
  const FoodDetailsPage({super.key,  required this.image, required this.id, required this.description, required this.name, required this.price});

  @override
  State<FoodDetailsPage> createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  final NutritionService _nutritionService = NutritionService();
  final CartService _cartService = CartService();
  Map<String, dynamic>? _foodData;
  bool _isLoading = false;
  String _error = '';
  String calorieInfo = "Waiting for API response...";
  String totalCarbs = "";
  String totalFat = "";
  String totalProtein = "";
  String cholesterol="";
  String calories="";
  String imageUrl = "https://example.com/path/to/your/image.jpeg"; // Replace with the network URL of the image

  // Function to download the image from the network
  Future<void> _getImageFromNetwork(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Get image bytes from response
        final imageBytes = response.bodyBytes;

        // Decode the image
        img.Image? image = img.decodeImage(Uint8List.fromList(imageBytes));

        if (image != null) {
          // Resize the image to fit below 512x512
          img.Image resizedImage = img.copyResize(image, width: 512, height: 512);

          // Convert the resized image back to bytes
          final resizedImageBytes = Uint8List.fromList(img.encodeJpg(resizedImage));

          // Send the resized image to the API
          _sendImageToApi(resizedImageBytes);
        } else {
          setState(() {
            calorieInfo = "Failed to decode image.";
          });
        }
      } else {
        setState(() {
          calorieInfo = "Failed to load image from URL.";
        });
      }
    } catch (e) {
      setState(() {
        calorieInfo = "Error occurred: $e";
      });
    }
  }


  // Function to process the API response
  Future<void> _processResponse(String responseBody) async {
    try {
      // Decode the response body into a Dart map
      var jsonResponse = json.decode(responseBody);

      // Check if the response is valid and contains food items
      if (jsonResponse['is_food'] == true && jsonResponse['results'].isNotEmpty) {
        var foodItem = jsonResponse['results'][0]['items'][0]; // Access the first item in results
        var nutrition = foodItem['nutrition'];
        // Extract the nutritional information

         totalCarbs = 'Total Carbs: ${nutrition['totalCarbs']}';
        totalFat = 'Total Fat: ${nutrition['totalFat']}';
        cholesterol = 'Total Cholesterol: ${nutrition['cholesterol']}';
        totalProtein = 'Total Protein: ${nutrition['protein']}';
        calories = 'Total Calories: ${nutrition['calories']/10} kcal';
        // Display the nutritional data
        setState(() {
          calorieInfo = "Total Carbs: $totalCarbs grams";
        });
      } else {
        setState(() {
          calorieInfo = "No valid food information found.";
        });
      }
    } catch (e) {
      setState(() {
        calorieInfo = "Error processing the response: $e";
      });
    }
  }
  // Function to send the image to the API
  Future<void> _sendImageToApi(Uint8List imageBytes) async {
    final uri = Uri.parse("https://api-2445582032290.production.gw.apicast.io/v1/foodrecognition?user_key=50f1452ebe936c5b88b05dafed808243");

    // Creating the multipart request
    var request = http.MultipartRequest('POST', uri)
      ..files.add(http.MultipartFile.fromBytes('media', imageBytes, filename: 'image.jpeg'));

    try {
      // Sending the request
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      print(responseBody);

      if (response.statusCode == 200) {
        // Parse the response

        _processResponse(responseBody);
        print(calorieInfo);
      } else {
        setState(() {
          calorieInfo = "Failed to recognize food.";
        });
      }
    } catch (e) {
      setState(() {
        calorieInfo = "Error sending image to API: $e";
      });
    }
  }
  @override
  void initState() {
    super.initState();
    _fetchFood(widget.name);
    _getImageFromNetwork( AppUrls.FoodImages+widget.image);
  }

  void _fetchFood(String query) async {

    print(query);
    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      final data = await _nutritionService.fetchFoodDetails(query);
      setState(() {
        _foodData = data;
        print(_foodData);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/restaurant.png'), // Add your background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Rounded Container for Content
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.65,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Popular Badge
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Popular',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Title and Icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.favorite_border, color: Colors.grey),
                          SizedBox(width: 10),
                          Icon(Icons.location_on_outlined, color: Colors.grey),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Rating, Calories, and Time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow, size: 18),
                          SizedBox(width: 5),
                          Text('4.9'),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.fireplace_outlined, color: Colors.red, size: 18),
                          SizedBox(width: 5),
                          Text('$calories Kcal'),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.access_time, color: Colors.grey, size: 18),
                          SizedBox(width: 5),
                          Text('7-10 Min'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Description
                  Text(
                    'A cheeseburger is a burger with a slice of melted cheese on top of the meat patty, added near the end of the cooking time. Cheeseburgers can include various toppings such as:',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  ),
                  SizedBox(height: 10),

                  // List of Ingredients
                  Row(
                    children: [
                      Expanded(
                        flex:9,
                        child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('• $totalCarbs',),
                          Text('• $totalProtein'),
                          Text('• $totalFat'),
                          Text('• $cholesterol',overflow: TextOverflow.ellipsis,),
                          Text('• $calories',overflow: TextOverflow.ellipsis,),
                        ],
                      ),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.network(
                              AppUrls.FoodImages+widget.image, // Add your burger image
                              height: 150,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),


                  // Image of the Burger

                  SizedBox(height: 20),

                  // Add to Cart Button
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final newItem = CartItem(
                          id: widget.id,
                          name: widget.name,
                          quantity: 1,
                          price: double.parse(widget.price),
                          calorie: '150',
                          image: AppUrls.FoodImages+widget.image, // Example calorie value as String
                        );
                        await _cartService.addToCart(newItem);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  CartScreen()),
                        );
                      },
                      icon: Icon(Icons.shopping_cart),
                      label: Text('ADD TO CART'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
