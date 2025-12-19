class GetMessageRoomModel {
  final int code;
  final String message;
  final MessageRoomData data;

  GetMessageRoomModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory GetMessageRoomModel.fromJson(Map<String, dynamic> json) {
    return GetMessageRoomModel(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      data: MessageRoomData.fromJson(json['data'] ?? {}),
    );
  }
}

class MessageRoomData {
  final List<MessageRoomAttributes> attributes;

  MessageRoomData({
    required this.attributes,
  });

  factory MessageRoomData.fromJson(Map<String, dynamic> json) {
    return MessageRoomData(
      attributes: (json['attributes'] as List<dynamic>? ?? [])
          .map((e) => MessageRoomAttributes.fromJson(e))
          .toList(),
    );
  }
}

class MessageRoomAttributes {
  final String id;
  final List<Participant> participants;
  final String lastMessage;
  final String createdAt;
  final String updatedAt;
  final int version;

  MessageRoomAttributes({
    required this.id,
    required this.participants,
    required this.lastMessage,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory MessageRoomAttributes.fromJson(Map<String, dynamic> json) {
    return MessageRoomAttributes(
      id: json['_id'] ?? '',
      participants: (json['participants'] as List<dynamic>? ?? [])
          .map((e) => Participant.fromJson(e))
          .toList(),
      lastMessage: json['lastMessage'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      version: json['__v'] ?? 0,
    );
  }
}

class Participant {
  final String id;
  final String userName;
  final String email;
  final String image;
  final String role;

  Participant({
    required this.id,
    required this.userName,
    required this.email,
    required this.image,
    required this.role,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['_id'] ?? '',
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      role: json['role'] ?? '',
    );
  }
}
