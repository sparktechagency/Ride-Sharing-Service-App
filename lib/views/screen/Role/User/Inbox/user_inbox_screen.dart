import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/views/base/custom_page_loading.dart';
import '../../../../../controllers/message_room_controller.dart';
import '../../../../../helpers/prefs_helpers.dart';
import '../../../../../helpers/route.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_strings.dart';
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
                  return Center(child: Text("No messages found".tr));
                }

                return ListView.builder(
                  itemCount: rooms.length,
                  itemBuilder: (context, index) {
                    final room = rooms[index];


                    final otherParticipants = room.participants.where((p) {
                      final pId = p.id.toString().trim();
                      final currentId = currentUserId.trim();
                      return pId != currentId && pId.isNotEmpty;
                    }).toList();

                  final participant = otherParticipants.isNotEmpty
                        ? otherParticipants.first
                        : room.participants.first;


                    if (otherParticipants.isEmpty && room.participants.length == 1) {
                      return const SizedBox.shrink();
                    }

                    final String otherUserName = participant.userName;
                    final String otherUserImage = 'https://faysal5500.sobhoy.com/${participant.image}';
                    final String roomId = room.id; // This is the _id from your JSON


                    DateTime updatedAt;
                    try {
                      updatedAt = DateTime.parse(room.updatedAt);
                    } catch (_) {
                      updatedAt = DateTime.now();
                    }
                    final messageTime = timeago.format(updatedAt);

                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: GestureDetector(
                        onTap: () {
                          // 2. Pass multiple arguments using a Map or List
                          Get.toNamed(
                            AppRoutes.userMessageScreen,
                            arguments: [
                              roomId,          // index 0
                              otherUserName,   // index 1
                              otherUserImage,  // index 2
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
                                      text: otherUserName.capitalize ?? 'User',
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      bottom: 4.h,
                                    ),
                                    CustomText(
                                      text: room.lastMessage,
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