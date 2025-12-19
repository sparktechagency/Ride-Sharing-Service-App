class CreateRatingResponse {
  final int code;
  final String message;
  final RatingData data;

  CreateRatingResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory CreateRatingResponse.fromJson(Map<String, dynamic> json) {
    return CreateRatingResponse(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      data: RatingData.fromJson(json['data'] ?? {}),
    );
  }
}

class RatingData {
  final RatingAttributes attributes;

  RatingData({required this.attributes});

  factory RatingData.fromJson(Map<String, dynamic> json) {
    return RatingData(
      attributes: RatingAttributes.fromJson(json['attributes'] ?? {}),
    );
  }
}

class RatingAttributes {
  final String author_id;
  final String ride;
  final String target_id;
  final int stars;
  final String review;
  final String id;
  final String createdAt;
  final String updatedAt;
  final int v;

  RatingAttributes({
    required this.author_id,
    required this.ride,
    required this.target_id,
    required this.stars,
    required this.review,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory RatingAttributes.fromJson(Map<String, dynamic> json) {
    return RatingAttributes(
      author_id: json['author_id'] ?? '',
      ride: json['ride'] ?? '',
      target_id: json['target_id'] ?? '',
      stars: json['stars'] ?? 0,
      review: json['review'] ?? '',
      id: json['_id'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
    );
  }
}
