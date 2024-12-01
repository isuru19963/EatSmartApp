class CartItem {
  final String id;
  final String name;
  final int quantity;
  final double price;
  final String calorie;
  final String image; // New image field as String

  CartItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.calorie,
    required this.image,
  });

  // Convert a CartItem to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
      'calorie': calorie,
      'image': image,
    };
  }

  // Create a CartItem from a Map
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      name: map['name'],
      quantity: map['quantity'],
      price: map['price'],
      calorie: map['calorie'],
      image: map['image'],
    );
  }
}
