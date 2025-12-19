class GetMessageModel {
  final int code;
  final String message;
  final GetMessageData data;

  GetMessageModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory GetMessageModel.fromJson(Map<String, dynamic> json) {
    return GetMessageModel(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      data: GetMessageData.fromJson(json['data'] ?? {}),
    );
  }
}

class GetMessageData {
  final List<GetMessageAttributes> attributes;

  GetMessageData({required this.attributes});

  factory GetMessageData.fromJson(Map<String, dynamic> json) {
    return GetMessageData(
      attributes: (json['attributes'] as List<dynamic>?)
          ?.map((e) => GetMessageAttributes.fromJson(e))
          .toList() ??
          [],
    );
  }
}
class GetMessageAttributes {
  final String id;
  final String message;
  final bool isSeen;
  final String sender_id;
  final String conversation_id;
  final String createdAt;
  final String updatedAt;
  final int version;

  GetMessageAttributes({
    required this.id,
    required this.message,
    required this.isSeen,
    required this.sender_id,
    required this.conversation_id,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory GetMessageAttributes.fromJson(Map<String, dynamic> json) {
    return GetMessageAttributes(
      id: json['_id'] ?? '',
      message: json['message'] ?? '',
      isSeen: json['isSeen'] ?? false,
      sender_id: json['sender_id'] ?? '',
      conversation_id: json['conversation_id'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      version: json['__v'] ?? 0,
    );
  }
}
