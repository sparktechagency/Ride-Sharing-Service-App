class BookingUserDetails {
  final int code;
  final String message;
  final BookingUserData? data;

  BookingUserDetails({
    required this.code,
    required this.message,
    required this.data,
  });

  factory BookingUserDetails.fromJson(Map<String, dynamic> json) {
    return BookingUserDetails(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      data: BookingUserData.fromJson(json['data'] ?? {}),
    );
  }
}

class BookingUserData {
  final BookingUserAttributes? attributes;

  BookingUserData({required this.attributes});

  factory BookingUserData.fromJson(Map<String, dynamic> json) {
    return BookingUserData(
      attributes: BookingUserAttributes.fromJson(json['attributes'] ?? {}),
    );
  }
}

class BookingUserAttributes {
  final String userId;
  final String userName;
  final String phoneNumber;
  final String address;
  final String? dateOfBirth;
  final String vehicleType;
  final String vehicleModel;
  final String profileImage;
  final double averageRating;
  final int totalReviews;
  final List<dynamic> reviews;

  BookingUserAttributes({
    required this.userId,
    required this.userName,
    required this.phoneNumber,
    required this.address,
    this.dateOfBirth,
    required this.vehicleType,
    required this.vehicleModel,
    required this.profileImage,
    required this.averageRating,
    required this.totalReviews,
    required this.reviews,
  });

  factory BookingUserAttributes.fromJson(Map<String, dynamic> json) {
    return BookingUserAttributes(
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      address: json['address'] ?? '',
      dateOfBirth: json['dateOfBirth'],
      vehicleType: json['vehicleType'] ?? '',
      vehicleModel: json['vehicleModel'] ?? '',
      profileImage: json['profileImage'] ?? '',
      averageRating: (json['averageRating'] ?? 0).toDouble(),
      totalReviews: json['totalReviews'] ?? 0,
      reviews: json['reviews'] ?? [],
    );
  }
}
