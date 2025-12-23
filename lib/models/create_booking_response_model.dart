class CreateBookingResponseModel {
  final int code;
  final String message;
  final BookingData? data;

  CreateBookingResponseModel({
    required this.code,
    required this.message,
    this.data,
  });

  factory CreateBookingResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateBookingResponseModel(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null ? BookingData.fromJson(json['data']) : null,
    );
  }
}
class BookingData {
  final CreateBookingAttributes? attributes;

  BookingData({this.attributes});

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      attributes: json['attributes'] != null
          ? CreateBookingAttributes.fromJson(json['attributes'])
          : null,
    );
  }
}
class CreateBookingAttributes {
  final String driverId;
  final String requested_id;
  final String author_name;
  final int price;
  final int number_of_people;
  final String vehicle_type;
  final CreateBookingLocationInfo? pickUp;
  final CreateBookingLocationInfo? dropOff;
  final String ride_date;
  final String status;
  final String ride_id;
  final String id;
  final String createdAt;
  final String updatedAt;
  final int v;

  CreateBookingAttributes({
    required this.driverId,
    required this.requested_id,
    required this.author_name,
    required this.price,
    required this.number_of_people,
    required this.vehicle_type,
    this.pickUp,
    this.dropOff,
    required this.ride_date,
    required this.status,
    required this.ride_id,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory CreateBookingAttributes.fromJson(Map<String, dynamic> json) {
    return CreateBookingAttributes(
      driverId: json['driverId'] ?? '',
      requested_id: json['requested_id'] ?? '',
      author_name: json['author_name'] ?? '',
      price: json['price'] ?? 0,
      number_of_people: json['number_of_people'] ?? 0,
      vehicle_type: json['vehicle_type'] ?? '',
      pickUp:
      json['pickUp'] != null ? CreateBookingLocationInfo.fromJson(json['pickUp']) : null,
      dropOff:
      json['dropOff'] != null ? CreateBookingLocationInfo.fromJson(json['dropOff']) : null,
      ride_date: json['ride_date'] ?? '',
      status: json['status'] ?? '',
      ride_id: json['ride_id'] ?? '',
      id: json['_id'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
    );
  }
}
class CreateBookingLocationInfo {
  final String address;
  final GeoLocation? location;

  CreateBookingLocationInfo({
    required this.address,
    this.location,
  });

  factory CreateBookingLocationInfo.fromJson(Map<String, dynamic> json) {
    return CreateBookingLocationInfo(
      address: json['address'] ?? '',
      location: json['location'] != null
          ? GeoLocation.fromJson(json['location'])
          : null,
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
      coordinates: json['coordinates'] != null
          ? List<double>.from(json['coordinates'])
          : <double>[],
    );
  }
}
