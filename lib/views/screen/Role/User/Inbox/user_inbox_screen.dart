import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../controllers/message_room_controller.dart';
import '../../../../../helpers/route.dart';
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

  @override
  void initState() {
    super.initState();
    // Explicitly set loading true first, then call API
    controller.isLoading(true);
    controller.getMessageRooms();
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: _searchCTRL,
              hintText: AppStrings.search.tr,
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Icon(Icons.search, color: Colors.grey),
              ),
            ),
            SizedBox(height: 16.h),

            //=============================> Chats List <========================
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.errorMessage.isNotEmpty) {
                  return Center(child: Text(controller.errorMessage.value));
                }

                if (controller.messageRooms.isEmpty) {
                  return Center(child: Text("No messages found".tr));
                }

                return ListView.builder(
                  itemCount: controller.messageRooms.length,
                  itemBuilder: (context, index) {
                    final room = controller.messageRooms[index];
                    final participant = room.participants.first;
                    final imageUrl =
                        'https://faysal5500.sobhoy.com/${participant.image}';

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
                          Get.toNamed(
                            AppRoutes.userMessageScreen,
                            arguments: room,
                          );
                        },
                        child: Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                          child: Row(
                            children: [
                              CustomNetworkImage(
                                imageUrl: imageUrl,
                                height: 56.h,
                                width: 56.w,
                                boxShape: BoxShape.circle,
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: participant.userName,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                      bottom: 6.h,
                                      maxLine: 2,
                                      textAlign: TextAlign.start,
                                    ),
                                    CustomText(
                                      text: room.lastMessage,
                                      fontWeight: FontWeight.w500,
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              CustomText(
                                text: messageTime,
                                fontSize: 12.sp,
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
