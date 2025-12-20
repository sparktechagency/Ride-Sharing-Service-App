class BookingUpdateModel {
  final int code;
  final String message;
  final BookingUpdateData? data;

  BookingUpdateModel({
    required this.code,
    required this.message,
    this.data,
  });

  factory BookingUpdateModel.fromJson(Map<String, dynamic> json) {
    return BookingUpdateModel(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? BookingUpdateData.fromJson(json['data'])
          : null,
    );
  }
}


class BookingUpdateData {
  final BookingAttributes? attributes;

  BookingUpdateData({this.attributes});

  factory BookingUpdateData.fromJson(Map<String, dynamic> json) {
    return BookingUpdateData(
      attributes: json['attributes'] != null
          ? BookingAttributes.fromJson(json['attributes'])
          : null,
    );
  }
}


class BookingAttributes {
  final PickDrop pickUp;
  final PickDrop dropOff;

  final String id; // _id
  final String driverId;
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
  final int v; // __v

  BookingAttributes({
    required this.pickUp,
    required this.dropOff,
    required this.id,
    required this.driverId,
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
    required this.v,
  });

  factory BookingAttributes.fromJson(Map<String, dynamic> json) {
    return BookingAttributes(
      pickUp: PickDrop.fromJson(json['pickUp'] ?? {}),
      dropOff: PickDrop.fromJson(json['dropOff'] ?? {}),
      id: json['_id'] ?? '',
      driverId: json['driverId'] ?? '',
      requestedId: json['requested_id'] ?? '',
      authorName: json['author_name'] ?? '',
      price: json['price'] ?? 0,
      numberOfPeople: json['number_of_people'] ?? 0,
      vehicleType: json['vehicle_type'] ?? '',
      rideDate: json['ride_date'] ?? '',
      status: json['status'] ?? '',
      rideId: json['ride_id'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
    );
  }
}


class PickDrop {
  final Location location;
  final String address;

  PickDrop({
    required this.location,
    required this.address,
  });

  factory PickDrop.fromJson(Map<String, dynamic> json) {
    return PickDrop(
      location: Location.fromJson(json['location'] ?? {}),
      address: json['address'] ?? '',
    );
  }
}


class Location {
  final String type;
  final List<double> coordinates;

  Location({
    required this.type,
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'] ?? '',
      coordinates: (json['coordinates'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList() ??
          [],
    );
  }
}
