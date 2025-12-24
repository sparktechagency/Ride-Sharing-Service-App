class SingleRideDetailsModel {
  final String id;
  final PickUpDropOff pickUp;
  final PickUpDropOff dropOff;
  final List<StopOver> stopOver;
  final int totalPassenger;
  final double pricePerSeat;
  final int seatsBooked;
  final String driverId;
  final String status;
  final double distanceKm;
  final double pricePerKm;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<BookingUser> bookingUsers;

  SingleRideDetailsModel({
    required this.id,
    required this.pickUp,
    required this.dropOff,
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
    required this.bookingUsers,
  });

  factory SingleRideDetailsModel.fromJson(Map<String, dynamic> json) {
    return SingleRideDetailsModel(
      id: json['_id'] ?? '',
      pickUp: PickUpDropOff.fromJson(json['pickUp'] ?? {}),
      dropOff: PickUpDropOff.fromJson(json['dropOff'] ?? {}),
      stopOver: (json['stopOver'] as List<dynamic>?)
          ?.map((e) => StopOver.fromJson(e))
          .toList() ??
          [],
      totalPassenger: json['totalPassenger'] ?? 0,
      pricePerSeat: (json['pricePerSeat'] ?? 0).toDouble(),
      seatsBooked: json['seatsBooked'] ?? 0,
      driverId: json['driverId'] ?? '',
      status: json['status'] ?? '',
      distanceKm: (json['distanceKm'] ?? 0).toDouble(),
      pricePerKm: (json['pricePerKm'] ?? 0).toDouble(),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      bookingUsers: (json['bookingUsers'] as List<dynamic>?)
          ?.map((e) => BookingUser.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class PickUpDropOff {
  final String address;
  final Coordinates location;

  PickUpDropOff({
    required this.address,
    required this.location,
  });

  factory PickUpDropOff.fromJson(Map<String, dynamic> json) {
    return PickUpDropOff(
      address: json['address'] ?? '',
      location: Coordinates.fromJson(json['location'] ?? {}),
    );
  }
}

class Coordinates {
  final String type;
  final List<double> coordinates;

  Coordinates({
    required this.type,
    required this.coordinates,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      type: json['type'] ?? '',
      coordinates: (json['coordinates'] as List<dynamic>?)
          ?.map((e) => (e ?? 0).toDouble())
          .cast<double>()
          .toList() ??
          [0.0, 0.0],
    );
  }
}

class StopOver {
  final String id;
  final String address;
  final Coordinates location;

  StopOver({
    required this.id,
    required this.address,
    required this.location,
  });

  factory StopOver.fromJson(Map<String, dynamic> json) {
    return StopOver(
      id: json['_id'] ?? '',
      address: json['address'] ?? '',
      location: Coordinates.fromJson(json['location'] ?? {}),
    );
  }
}

class BookingUser {
  final String userName;
  final String id;
  final String image;
  final int numberOfPeople;

  BookingUser({
    required this.userName,
    required this.id,
    required this.image,
    required this.numberOfPeople,
  });

  factory BookingUser.fromJson(Map<String, dynamic> json) {
    final user = json['user'] ?? {};
    return BookingUser(
      userName: user['userName'] ?? '',
      id: user['id'] ?? '',
      image: user['image'] ?? '',
      numberOfPeople: json['numberOfPeople'] ?? 0,
    );
  }
}
