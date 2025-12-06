import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
}
