class Product {
  final String id;
  final int price;
  final String name;
  final String imageUrl;
  final String description;
  final double rating;

  Product({
    required this.id,
    required this.price,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      price: json['price'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      rating: json['rating'],
    );
  }
}
