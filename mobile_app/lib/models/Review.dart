class Review {
  final String productID;
  final String username;
  final String comment;
  final String rating;

  Review({
    required this.productID,
    required this.username,
    required this.comment,
    required this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      productID: json['productID'],
      username: json['username'],
      comment: json['comment'],
      rating: json['rating'],
    );
  }
}
