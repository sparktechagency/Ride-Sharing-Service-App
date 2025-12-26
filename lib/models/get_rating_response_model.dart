class RatingsResponse {
  final int code;
  final String message;
  final RatingsData data;

  RatingsResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory RatingsResponse.fromJson(Map<String, dynamic> json) => RatingsResponse(
    code: json['code'] ?? 0,
    message: json['message'] ?? '',
    data: RatingsData.fromJson(json['data'] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    'code': code,
    'message': message,
    'data': data.toJson(),
  };
}

class RatingsData {
  final RatingsAttributes attributes;

  RatingsData({required this.attributes});

  factory RatingsData.fromJson(Map<String, dynamic> json) => RatingsData(
    attributes: RatingsAttributes.fromJson(json['attributes'] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    'attributes': attributes.toJson(),
  };
}

class RatingsAttributes {
  final int totalRatings;
  final double averageRating;
  final Map<String, int> breakdown;

  RatingsAttributes({
    required this.totalRatings,
    required this.averageRating,
    required this.breakdown,
  });

  factory RatingsAttributes.fromJson(Map<String, dynamic> json) => RatingsAttributes(
    totalRatings: json['totalRatings'] ?? 0,
    averageRating: (json['averageRating'] ?? 0).toDouble(),
    breakdown: Map<String, int>.from(json['breakdown'] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    'totalRatings': totalRatings,
    'averageRating': averageRating,
    'breakdown': breakdown,
  };
}
