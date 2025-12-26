import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/views/base/custom_page_loading.dart';
import '../../../../../controllers/message_room_controller.dart';
import '../../../../../helpers/prefs_helpers.dart';
import '../../../../../helpers/route.dart';
import '../../../../../service/api_constants.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../base/custom_button.dart';
import '../../../../base/custom_network_image.dart';
import '../../../../base/custom_text.dart';
import '../../../../base/custom_text_field.dart';
import '../BottomNavBar/user_bottom_menu..dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;


class UserInboxScreen extends StatefulWidget {
  const UserInboxScreen({super.key});

  @override
  State<UserInboxScreen> createState() => _UserInboxScreenState();
}

class _UserInboxScreenState extends State<UserInboxScreen> {
  final TextEditingController _searchCTRL = TextEditingController();
  final MessageRoomController controller = Get.put(MessageRoomController());
  String currentUserId = '';

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final id = await PrefsHelper.getString(AppConstants.id);
    String cleanId = id.trim() ?? '';

    setState(() {
      currentUserId = cleanId;
    });

    debugPrint('🟢 CURRENT USER ID: $currentUserId');

    // 1. Fetch existing rooms via API
    await controller.getMessageRooms();

    // 2. Initialize Inbox Socket to listen for real-time updates
    controller.initInboxSocket(cleanId);
  }

  @override
  void dispose() {
    controller.disposeSocket();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: UserBottomMenu(2),
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.inbox.tr,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            CustomTextField(
              controller: _searchCTRL,
              hintText: AppStrings.search.tr,
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              onChanged: (value) {
                controller.searchInbox(value);
              },
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CustomPageLoading());
                }

                final rooms = controller.filteredRooms;

                if (rooms.isEmpty) {
                  return Center(child: Text(AppStrings.noMessagesFound.tr));
                }

                return ListView.builder(
                  itemCount: rooms.length,
                  itemBuilder: (context, index) {
                    final room = rooms[index];

                    // Get all participants except current user
                    final otherParticipants = room.participants
                        .where((p) => p.id.toString().trim() != currentUserId.trim())
                        .toList();

                    // Pick the first other participant or fallback to the first one
                    final participant = otherParticipants.isNotEmpty
                        ? otherParticipants.first
                        : (room.participants.isNotEmpty ? room.participants.first : null);

                    if (participant == null) {
                      // No participants at all
                      return const SizedBox.shrink();
                    }

                    final lastMessage = (room.lastMessage != null && room.lastMessage!.isNotEmpty)
                        ? room.lastMessage!
                        : "No messages yet"; // This prevents the blank space confusion

                    // Safe extraction
                    final otherUserName =
                    participant.userName.isNotEmpty ? participant.userName : 'Unknown User';
                    final otherUserImage = (participant.image != null && participant.image!.isNotEmpty)
                        ? '${ApiConstants.imageBaseUrl}${participant.image}'
                        : ''; // placeholder


                    // Safe message time
                    DateTime updatedAt;
                    try {
                      updatedAt = DateTime.parse(room.updatedAt);
                    } catch (_) {
                      updatedAt = DateTime.now();
                    }
                    final messageTime = timeago.format(updatedAt);

                    final String roomId = room.id; // conversation _id

                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Dismissible(
                        key: Key(roomId),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        confirmDismiss: (direction) async {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (ctx) => Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              backgroundColor: Colors.transparent,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.cardColor,
                                  borderRadius: BorderRadius.circular(24.r),
                                  border: Border(
                                    top: BorderSide(width: 2.w, color: AppColors.primaryColor),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                                height: 265.h,
                                child: Column(
                                  children: [
                                    SizedBox(width: 48.w, child: Divider(color: AppColors.greyColor, thickness: 5.5)),
                                    SizedBox(height: 12.h),
                                    CustomText(
                                      text: AppStrings.deleteMessage.tr,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.sp,
                                    ),
                                    SizedBox(width: 190.w, child: Divider(color: AppColors.primaryColor)),
                                    SizedBox(height: 16.h),
                                    CustomText(
                                      text: AppStrings.areYouSureYouWantDeleteConversation.tr,
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
                                            await controller.deleteConversation(roomId);
                                          },
                                          text: AppStrings.yes.tr,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );

                          return false;
                        },
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.driverMessageScreen,
                              arguments: [
                                roomId,
                                otherUserName,
                                otherUserImage,
                              ],
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                )
                              ],
                            ),
                            child: Row(
                              children: [
                                CustomNetworkImage(
                                  imageUrl: otherUserImage,
                                  height: 50.h,
                                  width: 50.w,
                                  boxShape: BoxShape.circle,
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: otherUserName.capitalizeFirst ?? '', // Added capitalizeFirst
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                        bottom: 4.h,
                                      ),
                                      CustomText(
                                        text: lastMessage, // Now guaranteed to have text
                                        fontSize: 13.sp,
                                        maxLine: 1,
                                        color: Colors.grey,
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                CustomText(
                                  text: messageTime,
                                  fontSize: 11.sp,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );

              }),
            ),
          ],
        ),
      ),
    );
  }
}