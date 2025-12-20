class CreateMessageModel {
  int? code;
  String? message;
  CreateMessageData? data;

  CreateMessageModel({this.code, this.message, this.data});

  factory CreateMessageModel.fromJson(Map<String, dynamic> json) {
    return CreateMessageModel(
      code: json['code'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? CreateMessageData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'code': code,
    'message': message,
    'data': data?.toJson(),
  };
}

class CreateMessageData {
  CreateMessageAttributes? attributes;

  CreateMessageData({this.attributes});

  factory CreateMessageData.fromJson(Map<String, dynamic> json) {
    return CreateMessageData(
      attributes: json['attributes'] != null
          ? CreateMessageAttributes.fromJson(
          json['attributes'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'attributes': attributes?.toJson(),
  };
}

class CreateMessageAttributes {
  String? message;
  bool? isSeen;
  String? senderId;
  String? conversationId;
  String? sId; // for _id
  String? createdAt;
  String? updatedAt;
  int? iV; // for __v

  CreateMessageAttributes({
    this.message,
    this.isSeen,
    this.senderId,
    this.conversationId,
    this.sId,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  factory CreateMessageAttributes.fromJson(Map<String, dynamic> json) {
    return CreateMessageAttributes(
      message: json['message'] as String?,
      isSeen: json['isSeen'] as bool?,
      senderId: json['sender_id'] as String?,
      conversationId: json['conversation_id'] as String?,
      sId: json['_id'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      iV: json['__v'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'isSeen': isSeen,
    'sender_id': senderId,
    'conversation_id': conversationId,
    '_id': sId,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': iV,
  };
}
