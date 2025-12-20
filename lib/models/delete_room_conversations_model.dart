class DeleteRoomConversationsModel {
  int code;
  String message;
  DeleteConversationData? data;

  DeleteRoomConversationsModel({
    required this.code,
    required this.message,
    this.data,
  });

  factory DeleteRoomConversationsModel.fromJson(Map<String, dynamic> json) {
    return DeleteRoomConversationsModel(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? DeleteConversationData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'code': code,
    'message': message,
    'data': data?.toJson(),
  };
}

class DeleteConversationData {
  DeleteConversationAttributes? attributes;

  DeleteConversationData({this.attributes});

  factory DeleteConversationData.fromJson(Map<String, dynamic> json) {
    return DeleteConversationData(
      attributes: json['attributes'] != null
          ? DeleteConversationAttributes.fromJson(json['attributes'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'attributes': attributes?.toJson(),
  };
}

class DeleteConversationAttributes {
  String sId;
  List<String> participants;
  String lastMessage;
  String createdAt;
  String updatedAt;
  int v;

  DeleteConversationAttributes({
    required this.sId,
    required this.participants,
    required this.lastMessage,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory DeleteConversationAttributes.fromJson(Map<String, dynamic> json) {
    return DeleteConversationAttributes(
      sId: json['_id'] ?? '',
      participants: (json['participants'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
          [],
      lastMessage: json['lastMessage'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': sId,
    'participants': participants,
    'lastMessage': lastMessage,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
  };
}
