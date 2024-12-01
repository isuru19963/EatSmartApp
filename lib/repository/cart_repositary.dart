import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart_model.dart';


class CartService {
  static const String _cartKey = 'cart';

  Future<List<CartItem>> getCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartData = prefs.getString(_cartKey);
    if (cartData == null) {
      return [];
    }

    List<dynamic> cartList = jsonDecode(cartData);
    return cartList.map((item) => CartItem.fromMap(item)).toList();
  }

  Future<void> addToCart(CartItem item) async {
    final prefs = await SharedPreferences.getInstance();
    List<CartItem> cartItems = await getCartItems();

    // Check if the item already exists in the cart
    int index = cartItems.indexWhere((cartItem) => cartItem.id == item.id);
    if (index != -1) {
      // If the item exists, update the quantity
      cartItems[index] = CartItem(
        id: item.id,
        name: item.name,
        quantity: cartItems[index].quantity + item.quantity,
        price: item.price,
        calorie: item.calorie,
        image: item.image,
      );
    } else {
      // Otherwise, add the new item
      cartItems.add(item);
    }

    // Save the updated cart to SharedPreferences
    prefs.setString(
      'cart',
      jsonEncode(cartItems.map((e) => e.toMap()).toList()),
    );
  }


  Future<void> removeFromCart(String id) async {
    final prefs = await SharedPreferences.getInstance();
    List<CartItem> cartItems = await getCartItems();
    cartItems.removeWhere((item) => item.id == id);

    prefs.setString(_cartKey, jsonEncode(cartItems.map((e) => e.toMap()).toList()));
  }

  Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_cartKey);
  }
}
