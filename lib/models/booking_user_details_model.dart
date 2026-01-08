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
      data: json['data'] != null ? BookingUserData.fromJson(json['data']) : null,
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
  final double? averageRating;
  final int totalReviews;
  final List<UserReview> reviews;

  BookingUserAttributes({
    required this.userId,
    required this.userName,
    required this.phoneNumber,
    required this.address,
    this.dateOfBirth,
    required this.vehicleType,
    required this.vehicleModel,
    required this.profileImage,
    this.averageRating,
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
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      totalReviews: json['totalReviews'] ?? 0,
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => UserReview.fromJson(e))
          .toList() ??
          [],
    );
  }
}
class UserReview {
  final Reviewer reviewer;
  final int rating;
  final String createDate;
  final String review;

  UserReview({
    required this.reviewer,
    required this.rating,
    required this.createDate,
    required this.review,
  });

  factory UserReview.fromJson(Map<String, dynamic> json) {
    return UserReview(
      reviewer: json['reviewerId'] != null ? Reviewer.fromJson(json['reviewerId']) : Reviewer(id: '', userNameSelf: '', image: ''),
      rating: (json['rating'] as num?)?.toInt() ?? 0,
      createDate: json['createDate'] ?? '',
      review: json['review'] ?? '',
    );
  }
}
class Reviewer {
  final String id;
  final String userNameSelf;
  final String image;

  Reviewer({
    required this.id,
    required this.userNameSelf,
    required this.image,
  });

  factory Reviewer.fromJson(Map<String, dynamic> json) {
    return Reviewer(
      id: json['id'] ?? '',
      userNameSelf: json['userName'] ?? '',
      image: json['image'] ?? '',
    );
  }
}

