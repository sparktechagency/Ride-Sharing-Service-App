class SearchRideModel {
  final int code;
  final String message;
  final RideData data;

  SearchRideModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory SearchRideModel.fromJson(Map<String, dynamic> json) {
    return SearchRideModel(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      data: RideData.fromJson(json['data'] ?? {}),
    );
  }
}

class RideData {
  final List<RideAttribute> attributes;

  RideData({required this.attributes});

  factory RideData.fromJson(Map<String, dynamic> json) {
    return RideData(
      attributes: (json['attributes'] as List? ?? [])
          .map((e) => RideAttribute.fromJson(e))
          .toList(),
    );
  }
}
class RideAttribute {
  final String id; // _id
  final LocationInfo pickUp;
  final LocationInfo dropOff;
  final DateTime? goingDate;
  final List<StopOver> stopOver;
  final int totalPassenger;
  final int pricePerSeat;
  final int seatsBooked;
  final Driver driverId;
  final String status;
  final int distanceKm;
  final int pricePerKm;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int v; // __v

  RideAttribute({
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

  factory RideAttribute.fromJson(Map<String, dynamic> json) {
    return RideAttribute(
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
      driverId: Driver.fromJson(json['driverId'] ?? {}),
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
  final GeoLocation location;
  final String address;

  LocationInfo({
    required this.location,
    required this.address,
  });

  factory LocationInfo.fromJson(Map<String, dynamic> json) {
    return LocationInfo(
      location: GeoLocation.fromJson(json['location'] ?? {}),
      address: json['address'] ?? '',
    );
  }
}
class StopOver {
  final String id; // _id
  final GeoLocation location;
  final String address;

  StopOver({
    required this.id,
    required this.location,
    required this.address,
  });

  factory StopOver.fromJson(Map<String, dynamic> json) {
    return StopOver(
      id: json['_id'] ?? '',
      location: GeoLocation.fromJson(json['location'] ?? {}),
      address: json['address'] ?? '',
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
class Driver {
  final String email;
  final String id;

  Driver({
    required this.email,
    required this.id,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      email: json['email'] ?? '',
      id: json['id'] ?? '',
    );
  }
}

