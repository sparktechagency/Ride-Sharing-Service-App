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

    // Initialize socket for this conversation
    controller.initSocket(roomId,currentUserId);

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
                      return Center(child: Text(AppStrings.noMessageYet.tr));
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
              hintText: AppStrings.writeYourMessage,
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
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    final String tempId = "temp_${DateTime.now().millisecondsSinceEpoch}";

    final tempMessage = GetMessageAttributes(
      id: tempId,
      message: text,
      sender_id: currentUserId,
      isSeen: false,
      conversation_id: roomId,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );

    // 1. ADD IMMEDIATELY (UI feels instant)
    controller.messageGet.add(tempMessage);
    messageController.clear();
    _scrollToBottom();

    // 2. BACKGROUND API CALL (No full-screen loading)
    controller.createMessage(
      conversation_id: roomId,
      message: text,
    ).then((_) {
      final created = controller.createMessageData.value;
      if (created != null) {
        int index = controller.messageGet.indexWhere((m) => m.id == tempId);
        bool alreadyAddedBySocket = controller.messageGet.any((m) => m.id == created.sId);

        if (alreadyAddedBySocket && index != -1) {
          controller.messageGet.removeAt(index);
        } else if (index != -1) {
          // REPLACE TEMP WITH REAL DATA
          controller.messageGet[index] = GetMessageAttributes(
            id: created.sId ?? tempId,
            message: created.message ?? text,
            sender_id: created.senderId ?? currentUserId,
            isSeen: created.isSeen ?? false,
            conversation_id: created.conversationId ?? roomId,
            createdAt: created.createdAt ?? DateTime.now().toIso8601String(),
            updatedAt: created.updatedAt ?? DateTime.now().toIso8601String(),
          );
          controller.messageGet.refresh();
        }
      }
    });
  }


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
              backGroundColor: AppColors.cardColor,
              margin: EdgeInsets.only(bottom: 8.h),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.65,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
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

  Widget senderBubble(GetMessageAttributes msg) {
    // Check if this is a temporary local message
    final bool isSending = msg.id.startsWith('temp_');

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onLongPress: () => _showDeleteMessageBottomSheet(msg.id),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        msg.message,
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Expanded to push the status to the right
                          const Spacer(),
                          Text(
                            timeago.format(DateTime.parse(msg.createdAt)),
                            textAlign: TextAlign.end,
                            style: TextStyle(color: Colors.white70, fontSize: 10.sp),
                          ),
                          SizedBox(width: 4.w),
                          // Status Icon: Show clock for sending, checkmark for delivered
                          Icon(
                            isSending ? Icons.access_time_rounded : Icons.done_all,
                            size: 14.sp,
                            color: isSending ? Colors.white60 : Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w),
          ],
        ),
      ),
    );
  }


  PopupMenuButton<int> _popupMenuButton() {
    return PopupMenuButton<int>(
      onSelected: (value) {
        if (value == 0) {
          _showDeleteConversationBottomSheet(roomId);
        }
      },
      icon: const Icon(Icons.more_vert, color: Colors.white),
      itemBuilder: (_) => [
        PopupMenuItem(
          value: 0,
          child: Text(AppStrings.deleteConversation.tr), // Changed text to be more accurate
        ),
      ],
    );
  }


  void _showDeleteConversationBottomSheet(String conversationId) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
            border: Border(
              top: BorderSide(width: 2.w, color: AppColors.primaryColor),
            ),
            color: AppColors.cardColor,
          ),
          height: 265.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            children: [
              SizedBox(
                width: 48.w,
                child: Divider(color: AppColors.greyColor, thickness: 5.5),
              ),
              SizedBox(height: 12.h),
              CustomText(
                text: AppStrings.deleteConversation.tr,
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
              ),
              SizedBox(
                width: 190.w,
                child: Divider(color: AppColors.primaryColor),
              ),
              SizedBox(height: 16.h),
              CustomText(
                text: AppStrings.areYouSureToDeleteThisConversionThisNotUndone.tr,
                maxLine: 5,
              ),
              SizedBox(height: 48.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    width: 124.w,
                    height: 46.h,
                    onTap: () => Get.back(),
                    text: AppStrings.no.tr,
                    color: Colors.white,
                    textColor: AppColors.primaryColor,
                  ),
                  SizedBox(width: 16.w),
                  CustomButton(
                    width: 124.w,
                    height: 46.h,
                    onTap: () async {
                      // 1. Close bottom sheet
                      Get.back();

                      // 2. Call controller to delete
                      await controller.deleteConversation(conversationId);

                      // 3. Go back to the Inbox/Previous screen
                      Get.back();

                      // Optional: Show success message
                      Get.snackbar(AppStrings.success, AppStrings.conversationDeletedSuccess);
                    },
                    text: AppStrings.yes.tr,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }


  void _showDeleteMessageBottomSheet(String messageId) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
            border: Border(
              top: BorderSide(width: 2.w, color: AppColors.primaryColor),
            ),
            color: AppColors.cardColor,
          ),
          height: 265.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            children: [
              SizedBox(
                width: 48.w,
                child: Divider(color: AppColors.greyColor, thickness: 5.5),
              ),
              SizedBox(height: 12.h),
              CustomText(
                text: AppStrings.deleteMessage.tr,
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
              ),
              SizedBox(
                width: 190.w,
                child: Divider(color: AppColors.primaryColor),
              ),
              SizedBox(height: 16.h),
              CustomText(
                text: AppStrings.areYouSureToDeleteThisMessage.tr,
                maxLine: 5,
              ),
              SizedBox(height: 48.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    width: 124.w,
                    height: 46.h,
                    onTap: () => Get.back(),
                    text: AppStrings.no.tr,
                    color: Colors.white,
                    textColor: AppColors.primaryColor,
                  ),
                  SizedBox(width: 16.w),
                  CustomButton(
                    width: 124.w,
                    height: 46.h,
                    onTap: () async {
                      Get.back();
                      await controller.deleteMessage(messageId);
                    },
                    text: AppStrings.yes.tr,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }




}