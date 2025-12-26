class GetWalletDetailsResponseModel {
  final int? code;
  final String? message;
  final WalletDetailsData? data;

  GetWalletDetailsResponseModel({
    this.code,
    this.message,
    this.data,
  });

  factory GetWalletDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return GetWalletDetailsResponseModel(
      code: json['code'],
      message: json['message'],
      data: json['data'] != null ? WalletDetailsData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class WalletDetailsData {
  final WalletDetailsAttributes? attributes;

  WalletDetailsData({
    this.attributes,
  });

  factory WalletDetailsData.fromJson(Map<String, dynamic> json) {
    return WalletDetailsData(
      attributes: json['attributes'] != null ? WalletDetailsAttributes.fromJson(json['attributes']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attributes': attributes?.toJson(),
    };
  }
}

class WalletDetailsAttributes {
  final List<Transaction>? transaction;
  final Wallet? wallet;

  WalletDetailsAttributes({
    this.transaction,
    this.wallet,
  });

  factory WalletDetailsAttributes.fromJson(Map<String, dynamic> json) {
    return WalletDetailsAttributes(
      transaction: (json['transaction'] as List<dynamic>?)
          ?.map((e) => Transaction.fromJson(e))
          .toList(),
      wallet: json['wallet'] != null ? Wallet.fromJson(json['wallet']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transaction': transaction?.map((e) => e.toJson()).toList(),
      'wallet': wallet?.toJson(),
    };
  }
}

class Transaction {
  final String? id;
  final String? authorId;
  final String? driverId;
  final String? rideId;
  final double? totalAmount;
  final String? status;
  final String? paymentType;
  final String? paymentMethod;
  final String? referenceId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Transaction({
    this.id,
    this.authorId,
    this.driverId,
    this.rideId,
    this.totalAmount,
    this.status,
    this.paymentType,
    this.paymentMethod,
    this.referenceId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['_id'],
      authorId: json['author_id'],
      driverId: json['driverId'],
      rideId: json['ride_id'],
      totalAmount: (json['totalAmount'] is num) ? (json['totalAmount'] as num).toDouble() : json['totalAmount'],
      status: json['status'],
      paymentType: json['paymentType'],
      paymentMethod: json['paymentMethod'],
      referenceId: json['referenceId'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'author_id': authorId,
      'driverId': driverId,
      'ride_id': rideId,
      'totalAmount': totalAmount,
      'status': status,
      'paymentType': paymentType,
      'paymentMethod': paymentMethod,
      'referenceId': referenceId,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
    };
  }
}

class Wallet {
  final double? totalEarnings;
  final double? totalWithDrawal;

  Wallet({
    this.totalEarnings,
    this.totalWithDrawal,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      totalEarnings: (json['totalEarnings'] is num) ? (json['totalEarnings'] as num).toDouble() : json['totalEarnings'],
      totalWithDrawal: (json['totalWithDrawal'] is num) ? (json['totalWithDrawal'] as num).toDouble() : json['totalWithDrawal'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalEarnings': totalEarnings,
      'totalWithDrawal': totalWithDrawal,
    };
  }
}