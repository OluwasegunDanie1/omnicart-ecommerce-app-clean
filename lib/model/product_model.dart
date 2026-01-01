class CartItem {
  final String id;
  final String name;
  final double price;
  final String imageBase64;
  final int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageBase64,
    required this.quantity,
  });
}
