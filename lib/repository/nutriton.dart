import 'dart:convert';
import 'package:http/http.dart' as http;

class NutritionService {
  final String appId = "fc792771"; // Replace with your Nutritionix App ID
  final String appKey = "53e0f4709b18f618b5499b5d3946fd10"; // Replace with your Nutritionix App Key

  Future<Map<String, dynamic>> fetchFoodDetails(String query) async {
    final url = Uri.parse(
        "https://trackapi.nutritionix.com/v2/search/instant?query=$query");

    final headers = {
      "x-app-id": appId,
      "x-app-key": appKey,
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception("Failed to load food details");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
