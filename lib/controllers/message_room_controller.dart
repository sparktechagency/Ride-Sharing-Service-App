import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../models/create_message_model.dart';
import '../models/get_message_model.dart';
import '../models/get_message_room_model.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';

class MessageRoomController extends GetxController {

  IO.Socket? socket;
  String currentUserId = ''; // Store this to filter socket messages

  // Callback to trigger scroll in the UI
  Function? onNewMessageReceived;

  /// =================== COMMON STATES ===================
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  /// =================== MESSAGE ROOMS ===================
  final messageRooms = <MessageRoomAttributes>[].obs;

  /// =================== MESSAGE GETS ===================
  final messageGet = <GetMessageAttributes>[].obs;

  /// =================== CREATE MESSAGE ===================
  final createMessageData = Rxn<CreateMessageAttributes>();

  /// =================== DELETE MESSAGE ===================
  final deleteMessageData = Rxn<CreateMessageAttributes>();

  /// =================== FILTERED MESSAGE ROOMS (LOCAL SEARCH) ===================
  final filteredRooms = <MessageRoomAttributes>[].obs;

  /// ===================================================
  /// GET MESSAGE ROOMS
  /// ===================================================
  Future<void> getMessageRooms() async {
    try {
      isLoading(true);
      errorMessage('');

      final response =
      await ApiClient.getData(ApiConstants.getMessageRoomEndPoint);

      if (response.statusCode == 200) {
        final model = GetMessageRoomModel.fromJson(response.body);
        messageRooms.value = model.data.attributes;

        filteredRooms.assignAll(messageRooms);
      } else {
        errorMessage(response.statusText ?? 'Failed to load message rooms');
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  /// ===================================================
  /// GET MESSAGES
  /// ===================================================
  Future<void> getMessage(String id) async {
    try {
      isLoading(true);
      errorMessage('');

      final response =
      await ApiClient.getData('${ApiConstants.getMessage}$id');
      if (response.statusCode == 200) {
        final model = GetMessageModel.fromJson(response.body);
        messageGet.value = model.data.attributes;
      } else {
        errorMessage(response.statusText ?? 'Failed to load messages');
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  /// ===================================================
  /// CREATE MESSAGE
  /// ===================================================
  Future<void> createMessage({
    required String conversation_id,
    required String message,
  }) async {
    try {
      // REMOVED: isLoading(true); <- This was causing the full-screen spinner
      errorMessage('');

      final body = {
        'conversation_id': conversation_id,
        'message': message,
      };

      final response = await ApiClient.postData(ApiConstants.createMessage, body);

      if (response.statusCode == 201) {
        final model = CreateMessageModel.fromJson(response.body);
        createMessageData.value = model.data?.attributes;
      } else {
        // You can handle error silently or show a toast
        debugPrint('Failed to send message: ${response.statusText}');
      }
    } catch (e) {
      debugPrint('Create Message Error: $e');
    } finally {
      // REMOVED: isLoading(false);
    }
  }

  /// ===================================================
  /// DELETE MESSAGE
  /// ===================================================
  Future<void> deleteMessage(String messageId) async {
    try {
      isLoading(true);
      errorMessage('');

      final response =
      await ApiClient.deleteData('${ApiConstants.deleteMessage}$messageId');

      if (response.statusCode == 200 ) {
        final model = CreateMessageModel.fromJson(response.body);
        deleteMessageData.value = model.data?.attributes;

        // Remove the message locally from the list
        messageGet.removeWhere((msg) => msg.id == messageId);
      } else {
        errorMessage(response.statusText ?? 'Failed to delete message');
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }



  /// =================== SOCKET INIT ===================
  void initSocket(String conversationId, String userId) {
    currentUserId = userId; // Set the current user ID

    socket = IO.io(
      ApiConstants.socketBaseUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket!.connect();

    socket!.onConnect((_) {
      debugPrint('✅ Socket connected: ${socket!.id}');
    });

    socket!.onConnectError((err) => debugPrint('❌ Socket Connect Error: $err'));
    socket!.onError((err) => debugPrint('❌ Socket Error: $err'));

    // 3. LISTEN FOR NEW MESSAGES
    socket!.on('new-message::$conversationId', (data) {
      debugPrint('📩 New message received via Socket: $data');

      try {
        String incomingId = data['_id'] ?? '';
        String senderId = data['sender_id'] ?? '';

        // Check if message is already in list or if it's sent by me
        bool isMe = senderId.trim() == currentUserId.trim();
        bool exists = messageGet.any((msg) => msg.id == incomingId);

        if (!exists && !isMe) {
          final msg = GetMessageAttributes(
            id: incomingId,
            message: data['message'] ?? '',
            sender_id: senderId,
            isSeen: data['isSeen'] ?? false,
            conversation_id: data['conversation_id'] ?? '',
            createdAt: data['createdAt'] ?? DateTime.now().toIso8601String(),
            updatedAt: data['updatedAt'] ?? DateTime.now().toIso8601String(),
          );

          messageGet.add(msg);

          // Trigger the scroll callback if defined in UI
          if (onNewMessageReceived != null) {
            onNewMessageReceived!();
          }
          debugPrint('✨ Message added to UI from Receiver');
        } else {
          debugPrint('🚫 Ignored duplicate or own message from Socket');
        }
      } catch (e) {
        debugPrint('❌ Parsing Error: $e');
      }
    });

    socket!.onDisconnect((_) {
      debugPrint('⚠️ Socket disconnected');
    });
  }


  /// =================== INBOX SOCKET INIT ===================
  void initInboxSocket(String userId) {
    currentUserId = userId;

    socket = IO.io(
      ApiConstants.socketBaseUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket!.connect();

    socket!.onConnect((_) => debugPrint('✅ Inbox Socket connected: ${socket!.id}'));

    // LISTEN FOR NEW CONVERSATIONS OR UPDATES
    // Event: new-conversation::USER_ID
    socket!.on('new-conversation::$userId', (data) {
      debugPrint('📩 Inbox Update Received: $data');
      try {
        // Assuming 'data' matches your MessageRoomAttributes model structure
        final newRoom = MessageRoomAttributes.fromJson(data);

        // Check if this room already exists in our list
        int existingIndex = messageRooms.indexWhere((room) => room.id == newRoom.id);

        if (existingIndex != -1) {
          // 1. If it exists, remove old and insert at top (latest message first)
          messageRooms.removeAt(existingIndex);
          messageRooms.insert(0, newRoom);
        } else {
          // 2. If it's a brand new conversation, insert it at the top
          messageRooms.insert(0, newRoom);
        }

        messageRooms.refresh();
        filteredRooms.assignAll(messageRooms);
      } catch (e) {
        debugPrint('❌ Inbox Socket Error: $e');
      }
    });
  }

  void disposeSocket() {
    if (socket != null) {
      socket!.dispose();
      socket = null;
      onNewMessageReceived = null; // Clean up callback
      debugPrint('🧹 Socket resources cleaned up');
    }
  }



  /// =================== LOCAL INBOX SEARCH ===================
  void searchInbox(String query) {
    if (query.trim().isEmpty) {
      filteredRooms.assignAll(messageRooms);
      return;
    }

    final q = query.toLowerCase();

    filteredRooms.assignAll(
      messageRooms.where((room) {
        final otherParticipants = room.participants.where((p) {
          return p.id.toString().trim() != currentUserId.trim();
        }).toList();

        if (otherParticipants.isEmpty) return false;

        final name = otherParticipants.first.userName.toLowerCase();
        final lastMsg = room.lastMessage.toLowerCase();

        return name.contains(q) || lastMsg.contains(q);
      }).toList(),
    );
  }



}
