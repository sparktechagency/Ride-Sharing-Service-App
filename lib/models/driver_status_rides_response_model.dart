class DriverStatusRidesResponseModel {
  final int? code;
  final String? message;
  final StaticsData? data;

  DriverStatusRidesResponseModel({
    this.code,
    this.message,
    this.data,
  });

  factory DriverStatusRidesResponseModel.fromJson(Map<String, dynamic> json) {
    return DriverStatusRidesResponseModel(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? StaticsData.fromJson(json['data'])
          : null,
    );
  }
}

class StaticsData {
  final List<RideStaticsAttribute>? attributes;

  StaticsData({this.attributes});

  factory StaticsData.fromJson(Map<String, dynamic> json) {
    return StaticsData(
      attributes: (json['attributes'] as List?)
          ?.map((e) => RideStaticsAttribute.fromJson(e))
          .toList() ??
          [],
    );
  }
}
class RideStaticsAttribute {
  final String? id;
  final LocationInfo? pickUp;
  final LocationInfo? dropOff;
  final DateTime? goingDate;
  final int? totalPassenger;
  final int? pricePerSeat;
  final int? seatsBooked;
  final String? driverId;
  final String? status;
  final int? distanceKm;
  final DateTime? createdAt;

  RideStaticsAttribute({
    this.id,
    this.pickUp,
    this.dropOff,
    this.goingDate,
    this.totalPassenger,
    this.pricePerSeat,
    this.seatsBooked,
    this.driverId,
    this.status,
    this.distanceKm,
    this.createdAt,
  });

  factory RideStaticsAttribute.fromJson(Map<String, dynamic> json) {
    return RideStaticsAttribute(
      id: json['_id'] ?? '',
      pickUp: json['pickUp'] != null
          ? LocationInfo.fromJson(json['pickUp'])
          : null,
      dropOff: json['dropOff'] != null
          ? LocationInfo.fromJson(json['dropOff'])
          : null,
      goingDate: json['goingDate'] != null
          ? DateTime.tryParse(json['goingDate'])
          : null,
      totalPassenger: json['totalPassenger'] ?? 0,
      pricePerSeat: json['pricePerSeat'] ?? 0,
      seatsBooked: json['seatsBooked'] ?? 0,
      driverId: json['driverId'] ?? '',
      status: json['status'] ?? '',
      distanceKm: json['distanceKm'] ?? 0,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
    );
  }
}
class LocationInfo {
  final String? address;
  final GeoLocation? location;

  LocationInfo({
    this.address,
    this.location,
  });

  factory LocationInfo.fromJson(Map<String, dynamic> json) {
    return LocationInfo(
      address: json['address'] ?? '',
      location: json['location'] != null
          ? GeoLocation.fromJson(json['location'])
          : null,
    );
  }
}

class GeoLocation {
  final String? type;
  final List<double>? coordinates;

  GeoLocation({
    this.type,
    this.coordinates,
  });

  factory GeoLocation.fromJson(Map<String, dynamic> json) {
    return GeoLocation(
      type: json['type'] ?? 'Point',
      coordinates: (json['coordinates'] as List?)
          ?.map((e) => (e as num).toDouble())
          .toList() ??
          [],
    );
  }
}
