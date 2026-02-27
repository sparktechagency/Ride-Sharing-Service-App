class BookingWithStatusModel {
  final int code;
  final String message;
  final BookingStatusData data;

  BookingWithStatusModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory BookingWithStatusModel.fromJson(Map<String, dynamic> json) {
    return BookingWithStatusModel(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      data: BookingStatusData.fromJson(json['data'] ?? {}),
    );
  }
}


class BookingStatusData {
  final List<BookingAttribute> attributes;

  BookingStatusData({required this.attributes});

  factory BookingStatusData.fromJson(Map<String, dynamic> json) {
    return BookingStatusData(
      attributes: (json['attributes'] as List<dynamic>?)
          ?.map((e) => BookingAttribute.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class BookingAttribute {
  final PickDrop pickUp;
  final PickDrop dropOff;
  final String id;
  final DriverInfo driver;
  final String requestedId;
  final String authorName;
  final int price;
  final int numberOfPeople;
  final String vehicleType;
  final String rideDate;
  final String status;
  final String rideId;
  final String createdAt;
  final String updatedAt;

  BookingAttribute({
    required this.pickUp,
    required this.dropOff,
    required this.id,
    required this.driver,
    required this.requestedId,
    required this.authorName,
    required this.price,
    required this.numberOfPeople,
    required this.vehicleType,
    required this.rideDate,
    required this.status,
    required this.rideId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookingAttribute.fromJson(Map<String, dynamic> json) {
    return BookingAttribute(
      pickUp: PickDrop.fromJson(json['pickUp'] ?? {}),
      dropOff: PickDrop.fromJson(json['dropOff'] ?? {}),
      id: json['_id'] ?? '',
      driver: DriverInfo.fromJson(json['driverId'] ?? {}),
      requestedId: json['requested_id'] ?? '',
      authorName: json['author_name'] ?? '',
      price: (json['price'] as num?)?.toInt() ?? 0,
      numberOfPeople: (json['number_of_people'] as num?)?.toInt() ?? 0,
      vehicleType: json['vehicle_type'] ?? '',
      rideDate: json['ride_date'] ?? '',
      status: json['status'] ?? '',
      rideId: json['ride_id'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

class DriverInfo {
  final String id;
  final String userName;
  final String image;

  DriverInfo({
    required this.id,
    required this.userName,
    required this.image,
  });

  factory DriverInfo.fromJson(Map<String, dynamic> json) {
    return DriverInfo(
      id: json['id'] ?? '',
      userName: json['userName'] ?? '',
      image: json['image'] ?? '',
    );
  }
}


class PickDrop {
  final GeoLocation location;
  final String address;

  PickDrop({
    required this.location,
    required this.address,
  });

  factory PickDrop.fromJson(Map<String, dynamic> json) {
    return PickDrop(
      location: GeoLocation.fromJson(json['location'] ?? {}),
      address: json['address'] ?? '',
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
      coordinates: (json['coordinates'] as List<dynamic>?)
          ?.map((e) => (e as num?)?.toDouble() ?? 0.0)
          .toList() ??
          [],
    );
  }
}

