import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../../../controllers/message_room_controller.dart';
import '../../../../../../helpers/prefs_helpers.dart';
import '../../../../../../models/get_message_model.dart';
import '../../../../../../models/get_message_room_model.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_constants.dart';
import '../../../../../../utils/app_icons.dart';
import '../../../../../../utils/app_images.dart';
import '../../../../../../utils/app_strings.dart';
import '../../../../../base/custom_button.dart';
import '../../../../../base/custom_loading.dart';
import '../../../../../base/custom_network_image.dart';
import '../../../../../base/custom_page_loading.dart';
import '../../../../../base/custom_text.dart';
import '../../../../../base/custom_text_field.dart';


class UserMessageScreen extends StatefulWidget {
  const UserMessageScreen({super.key});

  @override
  State<UserMessageScreen> createState() => _UserMessageScreenState();
}

class _UserMessageScreenState extends State<UserMessageScreen> {
  final MessageRoomController controller = Get.put(MessageRoomController());
  final ScrollController _scrollController = ScrollController();
  final TextEditingController messageController = TextEditingController();

  late String roomId;
  late String partnerName;
  late String partnerImage;
  String currentUserId = '';

  @override
  void initState() {
    super.initState();
    final List<dynamic> args = Get.arguments;
    roomId = args[0];
    partnerName = args[1];
    partnerImage = args[2];

    _initChat();
  }

  Future<void> _initChat() async {
    currentUserId = await PrefsHelper.getString(AppConstants.id) ?? '';
    await controller.getMessage(roomId);
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Row(
          children: [
            CustomNetworkImage(
              imageUrl: partnerImage,
              height: 40.h,
              width: 40.w,
              boxShape: BoxShape.circle,
            ),
            SizedBox(width: 10.w),
            Flexible(
              child: CustomText(
                text: partnerName,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [_popupMenuButton()],
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 10.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CustomPageLoading());
                    }

                    if (controller.messageGet.isEmpty) {
                      return Center(child: Text("No messages yet".tr));
                    }

                    return ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.only(top: 16.h, bottom: 20.h),
                      itemCount: controller.messageGet.length,
                      itemBuilder: (context, index) {
                        final msg = controller.messageGet[index];

                        // Match using sender_id from your model/JSON
                        final bool isSender = msg.sender_id.trim() == currentUserId.trim();

                        return isSender
                            ? senderBubble(msg)
                            : receiverBubble(msg);
                      },
                    );
                  }),
                ),
                // Padding for bottom sheet
                SizedBox(height: 100.h),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _buildMessageInput(),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 30.h, top: 10.h),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
              controller: messageController,
              hintText: "Write your message...",
            ),
          ),
          SizedBox(width: 10.w),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration:  BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    // Local UI Update: Creating an object that matches GetMessageAttributes
    controller.messageGet.add(
      GetMessageAttributes(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // Temp ID
        message: messageController.text,
        sender_id: currentUserId,
        isSeen: false,
        conversation_id: roomId,
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
        version: 0,
      ),
    );

    messageController.clear();
    _scrollToBottom();
  }

  //=============================================> Receiver Bubble <=================================
  Widget receiverBubble(GetMessageAttributes msg) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          CustomNetworkImage(
            imageUrl: partnerImage,
            height: 38.h,
            width: 38.w,
            boxShape: BoxShape.circle,
          ),
          SizedBox(width: 8.w),
          // Bubble
          Flexible(
            child: ChatBubble(
              clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
              backGroundColor: AppColors.cardColor, // Light grey/card color
              margin: EdgeInsets.only(bottom: 8.h),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.65,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end, // Aligns time to right inside bubble
                  children: [
                    Text(
                      msg.message,
                      style: TextStyle(color: Colors.black, fontSize: 14.sp),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      timeago.format(DateTime.parse(msg.createdAt)),
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12.sp,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //=============================================> Sender Bubble <========================================
  Widget senderBubble(GetMessageAttributes msg) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Bubble
          Flexible(
            child: ChatBubble(
              clipper: ChatBubbleClipper5(type: BubbleType.sendBubble),
              alignment: Alignment.topRight,
              backGroundColor: AppColors.primaryColor,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.65,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Aligns text start
                  children: [
                    Text(
                      msg.message,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 4.h),
                    Align(
                      alignment: Alignment.centerRight, // Aligns time to right inside bubble
                      child: Text(
                        timeago.format(DateTime.parse(msg.createdAt)),
                        textAlign: TextAlign.end,
                        style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          // User Avatar (Shown on the right like your reference)
          Container(
            height: 38.h,
            width: 38.w,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(AppImages.user, fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }

  PopupMenuButton<int> _popupMenuButton() {
    return PopupMenuButton<int>(
      icon: const Icon(Icons.more_vert, color: Colors.white),
      itemBuilder: (_) => [
        PopupMenuItem(value: 0, child: Text('Block User'.tr)),
      ],
    );
  }
}