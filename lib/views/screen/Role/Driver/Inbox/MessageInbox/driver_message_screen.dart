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
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_icons.dart';
import '../../../../../../utils/app_images.dart';
import '../../../../../../utils/app_strings.dart';
import '../../../../../base/custom_button.dart';
import '../../../../../base/custom_loading.dart';
import '../../../../../base/custom_network_image.dart';
import '../../../../../base/custom_text.dart';
import '../../../../../base/custom_text_field.dart';


class DriverMessageScreen extends StatefulWidget {
  const DriverMessageScreen({super.key});

  @override
  State<DriverMessageScreen> createState() => _DriverMessageScreenState();
}

class _DriverMessageScreenState extends State<DriverMessageScreen> {
  final StreamController _streamController = StreamController();
  final ScrollController _scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();
  Uint8List? _image;
  File? selectedIMage;

  List<Map<String, String>> messageList = [
    {
      "name": "Alice",
      "status": "sender",
      "message": "Hey there!",
      "image": AppImages.user,
    },
    {
      "name": "Bob",
      "status": "receiver",
      "message": "Hi, what's up?",
      "image": AppImages.user,
    },
    {
      "name": "Charlie",
      "status": "sender",
      "message": "Just checking in.",
      "image": AppImages.user,
    },
    {
      "name": "David",
      "status": "receiver",
      "message": "Everything's good here, thanks!",
      "image": AppImages.user,
    },
    {
      "name": "Eve",
      "status": "sender",
      "message": "Cool.",
      "image": AppImages.user,
    },
    {
      "name": "Frank",
      "status": "receiver",
      "message": "Did you see the latest update?",
      "image": AppImages.user,
    },
    {
      "name": "Alice",
      "status": "sender",
      "message": "Hey there!",
      "image": AppImages.user,
    },
    {
      "name": "Bob",
      "status": "receiver",
      "message": "Hi, what's up?",
      "image": AppImages.user,
    },
    {
      "name": "Charlie",
      "status": "sender",
      "message": "Just checking in.",
      "image": AppImages.user,
    },
    {
      "name": "David",
      "status": "receiver",
      "message": "Everything's good here, thanks!",
      "image": AppImages.user,
    },
    {
      "name": "Eve",
      "status": "sender",
      "message": "Cool.",
      "image": AppImages.user,
    },
    {
      "name": "Frank",
      "status": "receiver",
      "message": "Did you see the latest update?",
      "image": AppImages.user,
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      // If you want a smooth scroll animation instead of jumping directly, use animateTo:
      // _scrollController.animateTo(
      //   _scrollController.position.maxScrollExtent,
      //   duration: Duration(milliseconds: 300),
      //   curve: Curves.easeOut,
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      //========================================> AppBar Section <=======================================
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        titleSpacing: 0.w,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomNetworkImage(
              imageUrl:
                  'https://t4.ftcdn.net/jpg/02/24/86/95/360_F_224869519_aRaeLneqALfPNBzg0xxMZXghtvBXkfIA.jpg',
              height: 45.h,
              width: 45.w,
              boxShape: BoxShape.circle,
            ),
            SizedBox(width: 8.w),
            Flexible(
              child: CustomText(
                text: 'Jane Cooper',
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          _popupMenuButton(),
          SizedBox(width: 4.w),
        ],
      ),
      //========================================> Body Section <=======================================
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      StreamBuilder(
                        stream: _streamController.stream,
                        builder: (context, snapshot) {
                          if (true) {
                            return ListView.builder(
                              controller: _scrollController,
                              dragStartBehavior: DragStartBehavior.down,
                              itemCount: messageList.length,
                              itemBuilder: (context, index) {
                                var message = messageList[index];
                                return message['status'] == "sender"
                                    ? senderBubble(context, message)
                                    : receiverBubble(context, message);
                              },
                            );
                          } else {
                            return const CustomLoading();
                          }
                        },
                      ),
                      //========================================> Show Select Image <============================
                      Positioned(
                        bottom: 0.h,
                        left: 0.w,
                        child: Column(
                          children: [
                            if (_image != null)
                              Stack(
                                children: [
                                  Container(
                                    height: 120.h,
                                    width: 120.w,
                                    margin: EdgeInsets.only(bottom: 10.h),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: MemoryImage(_image!),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(12.r),
                                      //border: Border.all(color: AppColors.primaryColor),
                                    ),
                                  ),
                                  //========================================> Cancel Icon <============================
                                  Positioned(
                                    top: 0.h,
                                    left: 0.w,
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: const Icon(Icons.cancel_outlined),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //===============================================> Write Sms Section <=============================
                SizedBox(height: 80.h),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 295.w,
                child: CustomTextField(
                  controller: messageController,
                  hintText: "Write your message...",
                ),
              ),
              SizedBox(width: 10.w),
              GestureDetector(
                onTap: () {
                  Map<String, String> newMessage = {
                    "name": "John",
                    "status": "sender",
                    "message": messageController.text,
                    "image": AppImages.user,
                  };
                  if (messageController.text.isNotEmpty) {
                    messageList.add(newMessage);
                    _streamController.sink.add(messageList);
                    print(messageList);
                    messageController.clear();
                    _image = null;
                  }
                  setState(() {});
                },
                child: SvgPicture.asset(AppIcons.send),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //=============================================> Receiver Bubble <=================================
  receiverBubble(BuildContext context, Map<String, String> message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 38.h,
          width: 38.w,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: Image.asset(message['image']!, fit: BoxFit.cover),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: ChatBubble(
            clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
            backGroundColor: AppColors.cardColor,
            margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.57.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    message['message'] ?? "",
                    style: TextStyle(color: Colors.black, fontSize: 14.sp),
                    textAlign: TextAlign.start,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          'time',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  //=============================================> Sender Bubble <========================================
  senderBubble(BuildContext context, Map<String, String> message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: ChatBubble(
            clipper: ChatBubbleClipper5(type: BubbleType.sendBubble),
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
            backGroundColor: AppColors.primaryColor,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.57,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message['message'] ?? "",
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'time',
                      textAlign: TextAlign.end,
                      style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Container(
          height: 38.h,
          width: 38.w,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: Image.asset(message['image']!, fit: BoxFit.cover),
        ),
      ],
    );
  }

  //==================================> Gallery <===============================
  Future openGallery() async {
    final pickImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      selectedIMage = File(pickImage!.path);
      _image = File(pickImage.path).readAsBytesSync();
    });
  }
  /*Future _pickImageFromGallery() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    // Get.back();
  }*/

  //================================> Popup Menu Button Method <=============================
  PopupMenuButton<int> _popupMenuButton() {
    return PopupMenuButton<int>(
      padding: EdgeInsets.zero,
      icon: SvgPicture.asset(AppIcons.dot, color: Colors.white),
      onSelected: (int result) {
        if (result == 0) {
          print('View Profile');
        } else if (result == 1) {
          print('Delete Chat ');
        }
      },
      itemBuilder:
          (BuildContext context) => <PopupMenuEntry<int>>[
            PopupMenuItem<int>(
              value: 0,
              child: const Text(
                'View Profile',
                style: TextStyle(color: Colors.black),
              ),
            ),
            PopupMenuItem<int>(
              onTap: () {
                _showCustomBottomSheet(context);
              },
              value: 1,
              child: const Text(
                'Delete Chat',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
    );
  }

  //===============================> Delete conversation Bottom Sheet <===============================
  _showCustomBottomSheet(BuildContext context) {
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
          padding: EdgeInsets.symmetric(horizontal:  16.w, vertical: 8.h),
          child: Column(
            children: [
              SizedBox(
                width: 48.w,
                child: Divider(color: AppColors.greyColor, thickness: 5.5,),
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
                text: 'Are you sure you want to delete this conversation?'.tr,
                maxLine: 5,
              ),
              SizedBox(height: 48.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    width: 124.w,
                    height: 46.h,
                    onTap: () {
                      Get.back();
                    },
                    text: "No",
                    color: Colors.white,
                    textColor: AppColors.primaryColor,
                  ),
                  SizedBox(width: 16.w),
                  CustomButton(
                    width: 124.w,
                    height: 46.h,
                    onTap: () {
                      // Get.offAllNamed(AppRoutes.signInScreen);
                    },
                    text: "Yes",
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
