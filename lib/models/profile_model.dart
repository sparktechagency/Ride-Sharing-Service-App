class ProfileModel {
  final String? userName;
  final String? email;
  final String? image;
  final String? password;
  final String? type;
  final String? role;
  final String? address;
  final DateTime? dateOfBirth;
  final String? vehicleType;
  final String? vehicleModel;
  final String? licensePlateNumber;
  final String? licenseFrontUrl;
  final String? licenseBackUrl;
  final String? phoneNumber;
  final bool? isProfileCompleted;
  final int? totalEarnings;
  final int? totalWithDrawal;
  final int? totalRatings;
  final int? totalRides;
  final DateTime? createdAt;
  final bool? licenseVerified;
  final String? id;

  ProfileModel({
    this.userName,
    this.email,
    this.image,
    this.password,
    this.type,
    this.role,
    this.address,
    this.dateOfBirth,
    this.vehicleType,
    this.vehicleModel,
    this.licensePlateNumber,
    this.licenseFrontUrl,
    this.licenseBackUrl,
    this.phoneNumber,
    this.isProfileCompleted,
    this.totalEarnings,
    this.totalWithDrawal,
    this.totalRatings,
    this.totalRides,
    this.createdAt,
    this.licenseVerified,
    this.id,
  });

  factory ProfileModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return ProfileModel();
    }
    return ProfileModel(
      userName: json["userName"],
      email: json["email"],
      image: json["image"],
      password: json["password"],
      type: json["type"],
      role: json["role"],
      address: json["address"],
      dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
      vehicleType: json["vehicleType"],
      vehicleModel: json["vehicleModel"],
      licensePlateNumber: json["licensePlateNumber"],
      licenseFrontUrl: json["licenseFrontUrl"],
      licenseBackUrl: json["licenseBackUrl"],
      phoneNumber: json["phoneNumber"],
      isProfileCompleted: json["isProfileCompleted"],
      totalEarnings: json["totalEarnings"],
      totalWithDrawal: json["totalWithDrawal"],
      totalRatings: json["totalRatings"],
      totalRides: json["totalRides"],
      createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      licenseVerified: json["licenseVerified"],
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "userName": userName,
    "email": email,
    "image": image,
    "password": password,
    "type": type,
    "role": role,
    "address": address,
    "dateOfBirth": dateOfBirth?.toIso8601String(),
    "vehicleType": vehicleType,
    "vehicleModel": vehicleModel,
    "licensePlateNumber": licensePlateNumber,
    "licenseFrontUrl": licenseFrontUrl,
    "licenseBackUrl": licenseBackUrl,
    "phoneNumber": phoneNumber,
    "isProfileCompleted": isProfileCompleted,
    "totalEarnings": totalEarnings,
    "totalWithDrawal": totalWithDrawal,
    "totalRatings": totalRatings,
    "totalRides": totalRides,
    "createdAt": createdAt?.toIso8601String(),
    "licenseVerified": licenseVerified,
    "id": id,
  };
}