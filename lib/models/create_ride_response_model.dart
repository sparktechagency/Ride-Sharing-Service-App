class CreateRideResponseModel {
  final int code;
  final String message;
  final CreateRideData? data;

  CreateRideResponseModel({
    required this.code,
    required this.message,
    this.data,
  });

  factory CreateRideResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateRideResponseModel(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? CreateRideData.fromJson(json['data'])
          : null,
    );
  }
}
class CreateRideData {
  final CreateRideAttributes? attributes;

  CreateRideData({this.attributes});

  factory CreateRideData.fromJson(Map<String, dynamic> json) {
    return CreateRideData(
      attributes: json['attributes'] != null
          ? CreateRideAttributes.fromJson(json['attributes'])
          : null,
    );
  }
}
class CreateRideAttributes {
  final String id; // _id
  final LocationInfo pickUp;
  final LocationInfo dropOff;
  final DateTime? goingDate;
  final List<StopOver> stopOver;
  final int totalPassenger;
  final int pricePerSeat;
  final int seatsBooked;
  final String driverId;
  final String status;
  final int distanceKm;
  final int pricePerKm;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int v; // __v

  CreateRideAttributes({
    required this.id,
    required this.pickUp,
    required this.dropOff,
    required this.goingDate,
    required this.stopOver,
    required this.totalPassenger,
    required this.pricePerSeat,
    required this.seatsBooked,
    required this.driverId,
    required this.status,
    required this.distanceKm,
    required this.pricePerKm,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory CreateRideAttributes.fromJson(Map<String, dynamic> json) {
    return CreateRideAttributes(
      id: json['_id'] ?? '',
      pickUp: LocationInfo.fromJson(json['pickUp'] ?? {}),
      dropOff: LocationInfo.fromJson(json['dropOff'] ?? {}),
      goingDate: json['goingDate'] != null
          ? DateTime.tryParse(json['goingDate'])
          : null,
      stopOver: (json['stopOver'] as List? ?? [])
          .map((e) => StopOver.fromJson(e))
          .toList(),
      totalPassenger: json['totalPassenger'] ?? 0,
      pricePerSeat: json['pricePerSeat'] ?? 0,
      seatsBooked: json['seatsBooked'] ?? 0,
      driverId: json['driverId'] ?? '',
      status: json['status'] ?? '',
      distanceKm: json['distanceKm'] ?? 0,
      pricePerKm: json['pricePerKm'] ?? 0,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      v: json['__v'] ?? 0,
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
class StopOver {
  final String id; // _id
  final String address;
  final GeoLocation location;

  StopOver({
    required this.id,
    required this.address,
    required this.location,
  });

  factory StopOver.fromJson(Map<String, dynamic> json) {
    return StopOver(
      id: json['_id'] ?? '',
      address: json['address'] ?? '',
      location: GeoLocation.fromJson(json['location'] ?? {}),
    );
  }
}
class GeoLocation {
  final List<double> coordinates;
  final String type;

  GeoLocation({
    required this.coordinates,
    required this.type,
  });

  factory GeoLocation.fromJson(Map<String, dynamic> json) {
    return GeoLocation(
      coordinates: (json['coordinates'] as List? ?? [])
          .map((e) => (e as num).toDouble())
          .toList(),
      type: json['type'] ?? '',
    );
  }
}
