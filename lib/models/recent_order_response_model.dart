class RecentOrderResponseModel {
  final int code;
  final String message;
  final RecentOrderData data;

  RecentOrderResponseModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory RecentOrderResponseModel.fromJson(Map<String, dynamic> json) {
    return RecentOrderResponseModel(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      data: RecentOrderData.fromJson(json['data'] ?? {}),
    );
  }
}
class RecentOrderData {
  final List<RecentOrderAttribute> attributes;

  RecentOrderData({
    required this.attributes,
  });

  factory RecentOrderData.fromJson(Map<String, dynamic> json) {
    return RecentOrderData(
      attributes: (json['attributes'] as List? ?? [])
          .map((e) => RecentOrderAttribute.fromJson(e))
          .toList(),
    );
  }
}
class RecentOrderAttribute {
  final String id;
  final int price;
  final int numberOfPeople;
  final String vehicleType;
  final LocationInfo pickUp;
  final LocationInfo dropOff;
  final String rideDate;
  final String status;
  final String createdAt;
  final OrderUser user;

  RecentOrderAttribute({
    required this.id,
    required this.price,
    required this.numberOfPeople,
    required this.vehicleType,
    required this.pickUp,
    required this.dropOff,
    required this.rideDate,
    required this.status,
    required this.createdAt,
    required this.user,
  });

  factory RecentOrderAttribute.fromJson(Map<String, dynamic> json) {
    return RecentOrderAttribute(
      id: json['_id'] ?? '',
      price: json['price'] ?? 0,
      numberOfPeople: json['number_of_people'] ?? 0,
      vehicleType: json['vehicle_type'] ?? '',
      pickUp: LocationInfo.fromJson(json['pickUp'] ?? {}),
      dropOff: LocationInfo.fromJson(json['dropOff'] ?? {}),
      rideDate: json['ride_date'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['createdAt'] ?? '',
      user: OrderUser.fromJson(json['user'] ?? {}),
    );
  }
}
class LocationInfo {
  final String address;
  final GeoLocation location;

  LocationInfo({
    required this.address,
    required this.location,
  });

  factory LocationInfo.fromJson(Map<String, dynamic> json) {
    return LocationInfo(
      address: json['address'] ?? '',
      location: GeoLocation.fromJson(json['location'] ?? {}),
    );
  }
}
class GeoLocation {
  final String type;
  final List<double> coordinates;

  GeoLocation({
    required this.type,
    required this.coordinates,
  });

  factory GeoLocation.fromJson(Map<String, dynamic> json) {
    return GeoLocation(
      type: json['type'] ?? '',
      coordinates: (json['coordinates'] as List? ?? [])
          .map((e) => (e as num?)?.toDouble() ?? 0.0)
          .toList(),
    );
  }
}
class OrderUser {
  final String id;
  final String userName;
  final String image;
  final int totalRatings;
  final double averageRating;

  OrderUser({
    required this.id,
    required this.userName,
    required this.image,
    required this.totalRatings,
    required this.averageRating,
  });

  factory OrderUser.fromJson(Map<String, dynamic> json) {
    return OrderUser(
      id: json['_id'] ?? '',
      userName: json['userName'] ?? '',
      image: json['image'] ?? '',
      totalRatings: json['totalRatings'] ?? 0,
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
