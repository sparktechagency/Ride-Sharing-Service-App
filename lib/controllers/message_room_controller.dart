
import 'package:get/get.dart';

import '../models/get_message_room_model.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';

class MessageRoomController extends GetxController {
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final messageRooms = <MessageRoomAttributes>[].obs;

  @override
  void onInit() {
    super.onInit();
    getMessageRooms(); // fetch once on controller init
  }

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
}
