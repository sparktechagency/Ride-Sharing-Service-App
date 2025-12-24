import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ride_sharing/views/base/custom_text.dart';

import '../models/profile_model.dart';
import '../service/api_checker.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';
import '../utils/app_colors.dart';

class ProfileController extends GetxController {
  File? selectedImage;
  RxString imagesPath = ''.obs;
  String title = "Profile Screen";
  RxString frontSitePath = ''.obs;
  RxString backSitePaths = ''.obs;

  RxBool isUpdateLoading = false.obs;

  @override
  void onInit() {
    debugPrint("On Init  $title");
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    debugPrint("On onReady  $title");
    super.onReady();
  }

  //=============================> Get Account Data <===============================
  Rx<ProfileModel> profileModel = ProfileModel().obs;
  RxBool profileLoading = false.obs;
  getProfileData() async {
    profileLoading(true);
    var response = await ApiClient.getData(
      ApiConstants.getPersonalInfoEndPoint,
    );
    print("my response : ${response.body}");
    if (response.statusCode == 200) {
      profileModel.value = ProfileModel.fromJson(
        response.body['data']['attributes']['user'],
      );
      profileLoading(false);
      update();
    } else {
      ApiChecker.checkApi(response);
      profileLoading(false);
      update();
    }
  }

  //===============================> Edit Profile Screen <=============================
  final TextEditingController userNameCTRL = TextEditingController();
  final TextEditingController phoneCTRL = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController dateBirthCTRL = TextEditingController();
  final TextEditingController typeCTRL = TextEditingController();
  final TextEditingController modelCTRL = TextEditingController();
  final TextEditingController licenseCTRL = TextEditingController();

  //===============================> Image Picker <=============================
  Future pickImage(ImageSource source) async {
    final returnImage = await ImagePicker().pickImage(source: source);
    if (returnImage == null) return;
    selectedImage = File(returnImage.path);
    imagesPath.value = selectedImage!.path;
    //  image = File(returnImage.path).readAsBytesSync();
    update();
    print('ImagesPath===========================>:${imagesPath.value}');
    Get.back(); //
  }

  //==========================> Show Calender Function <=======================
  Future<void> pickBirthDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(3050),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
              onSurface: Colors.black, // Text color
            ),
            dialogTheme: DialogThemeData(backgroundColor: Colors.white),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      dateBirthCTRL.text =
          "${pickedDate.month}-${pickedDate.day}-${pickedDate.year}";
    }
  }

  //==========================> Pick Type Image <=======================
  Future<Uint8List?> pickTypeImage(ImageSource source, String imageType) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final Uint8List imageBytes = await pickedFile.readAsBytes();
      if (imageType == 'frontSite') {
        frontSitePath.value = pickedFile.path;
      } else if (imageType == 'backSite') {
        backSitePaths.value = pickedFile.path;
      }
      return imageBytes;
    }
    return null;
  }


//=============================> Update Profile <===============================
  Future<void> updateProfile(BuildContext context) async {
    isUpdateLoading(true);

    // 1. Prepare Text Fields (Body)
    Map<String, String> body = {
      if (userNameCTRL.text.isNotEmpty) "userName": userNameCTRL.text,
      if (phoneCTRL.text.isNotEmpty) "phoneNumber": phoneCTRL.text,
      if (addressCtrl.text.isNotEmpty) "address": addressCtrl.text,
      if (dateBirthCTRL.text.isNotEmpty) "dateOfBirth": dateBirthCTRL.text,
      if (typeCTRL.text.isNotEmpty) "vehicleType": typeCTRL.text,
      if (modelCTRL.text.isNotEmpty) "vehicleModel": modelCTRL.text,
      if (licenseCTRL.text.isNotEmpty) "licensePlateNumber": licenseCTRL.text,

      // Sending these as Strings (paths) instead of files
      if (frontSitePath.value.isNotEmpty) "licenseFrontUrl": frontSitePath.value,
      if (backSitePaths.value.isNotEmpty) "licenseBackUrl": backSitePaths.value,
    };

    // 2. Prepare Image Fields (Only profile image as File)
    List<MultipartBody> multipartBody = [];
    if (imagesPath.value.isNotEmpty) {
      multipartBody.add(MultipartBody("image", File(imagesPath.value)));
    }

    try {
      var response = await ApiClient.patchMultipartData(
        ApiConstants.updateProfileData,
        body,
        multipartBody: multipartBody,
      );

      if (response.statusCode == 200) {
        // Close the Edit Screen
        Get.back();

        // Use ScaffoldMessenger for success notification
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
              content: CustomText(text: "User Updated Successfully".tr,color: AppColors.backgroundColor,),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }

        // Refresh the profile data to update the main screen
        getProfileData();

        // Clear local image path after successful upload
        imagesPath.value = '';
      } else {
        // Handle API errors (e.g., token expired or server error)
        ApiChecker.checkApi(response);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.body['message'] ?? "Update failed"),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      debugPrint("Update Error: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("An error occurred: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      isUpdateLoading(false);
    }
  }}
