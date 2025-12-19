
import 'package:get/get.dart';

import '../models/create_message_model.dart';
import '../models/get_message_model.dart';
import '../models/get_message_room_model.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';

class MessageRoomController extends GetxController {
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
      isLoading(true);
      errorMessage('');

      final body = {
        'conversation_id': conversation_id,
        'message': message,
      };

      final response =
      await ApiClient.postData(ApiConstants.createMessage, body);

      if (response.statusCode == 201) {
        final model = CreateMessageModel.fromJson(response.body);
        createMessageData.value = model.data?.attributes;
      } else {
        errorMessage(response.statusText ?? 'Failed to create message');
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
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
}
