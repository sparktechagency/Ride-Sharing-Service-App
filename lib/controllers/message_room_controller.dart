
import 'package:get/get.dart';

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

  /// ===================================================
  /// GET MESSAGE ROOMS
  /// ===================================================
  Future<void> getMessageRooms() async {
    try {
      isLoading(true);
      errorMessage('');

      final response = await ApiClient.getData(ApiConstants.getMessageRoomEndPoint);

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
/// GET MESSAGE ROOMS
/// ===================================================
///
Future<void> getMessage(String id) async {
    try {
      isLoading(true);
      errorMessage('');

      final response = await ApiClient.getData( '${ApiConstants.getMessage}$id',);
      if (response.statusCode == 200) {
        final model = GetMessageModel.fromJson(response.body);
        messageGet.value = model.data.attributes;
      } else {
        errorMessage(response.statusText ?? 'Failed to load message rooms');
      }
    }
    catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
}


}
