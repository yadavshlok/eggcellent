class Review {
  final String id;
  final String userName;
  final int rating;
  final String comment;
  final DateTime createdAt;
  final int helpfulCount;

  Review({
    required this.id,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.createdAt,
    this.helpfulCount = 0,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      userName: json['userName'],
      rating: json['rating'],
      comment: json['comment'],
      createdAt: DateTime.parse(json['createdAt']),
      helpfulCount: json['helpfulCount'] ?? 0,
    );
  }
}
