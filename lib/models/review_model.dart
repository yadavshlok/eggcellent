class Review {
  final String id;
  final String farmId;
  final String userId;
  final double qualityRating;
  final double serviceRating;
  final String comment;
  final List<String>? images;
  final int helpfulCount;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.farmId,
    required this.userId,
    required this.qualityRating,
    required this.serviceRating,
    required this.comment,
    this.images,
    this.helpfulCount = 0,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      farmId: json['farmId'],
      userId: json['userId'],
      qualityRating: (json['qualityRating'] ?? 0.0).toDouble(),
      serviceRating: (json['serviceRating'] ?? 0.0).toDouble(),
      comment: json['comment'],
      images: (json['images'] as List?)?.cast<String>(),
      helpfulCount: json['helpfulCount'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class ReviewStats {
  final double averageRating;
  final int totalReviews;
  final Map<int, int> ratingDistribution;

  ReviewStats({
    required this.averageRating,
    required this.totalReviews,
    required this.ratingDistribution,
  });

  factory ReviewStats.fromJson(Map<String, dynamic> json) {
    return ReviewStats(
      averageRating: (json['averageRating'] ?? 0.0).toDouble(),
      totalReviews: json['totalReviews'] ?? 0,
      ratingDistribution: Map<int, int>.from(json['ratingDistribution'] ?? {}),
    );
  }
}
