class PrivacyPolicyModel {
  final int? code;
  final String? message;
  final PrivacyPolicyData? data;

  PrivacyPolicyModel({
    this.code,
    this.message,
    this.data,
  });

  factory PrivacyPolicyModel.fromJson(Map<String, dynamic> json) {
    return PrivacyPolicyModel(
      code: json['code'],
      message: json['message'],
      data: json['data'] != null ? PrivacyPolicyData.fromJson(json['data']) : null,
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

class PrivacyPolicyData {
  final PrivacyPolicyAttributes? attributes;

  PrivacyPolicyData({
    this.attributes,
  });

  factory PrivacyPolicyData.fromJson(Map<String, dynamic> json) {
    return PrivacyPolicyData(
      attributes: json['attributes'] != null ? PrivacyPolicyAttributes.fromJson(json['attributes']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attributes': attributes?.toJson(),
    };
  }
}

class PrivacyPolicyAttributes {
  final String? id;
  final String? content;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  PrivacyPolicyAttributes({
    this.id,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory PrivacyPolicyAttributes.fromJson(Map<String, dynamic> json) {
    return PrivacyPolicyAttributes(
      id: json['_id'],
      content: json['content'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'content': content,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
    };
  }
}