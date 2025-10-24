import 'dart:io';
import 'package:get/get.dart';
import '../helpers/route.dart';
import '../service/api_checker.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';

class LicenseUploadController extends GetxController {
  var imagePaths = List<String>.filled(2, '').obs;
  var uploadGalleryLoading = false.obs;

  Future<void> uploadLicenseImages({bool isUpdate = false}) async {
    final front = imagePaths[0];
    final back = imagePaths[1];

    if (front.isEmpty || back.isEmpty) {
      Get.snackbar('Error', 'Both front and back images are required.');
      return;
    }

    uploadGalleryLoading.value = true;
    update();

    try {
      List<MultipartBody> multipartBody = [
        MultipartBody('image', File(front)),
        MultipartBody('image', File(back)),
      ];

      var response = await ApiClient.postMultipartData(
        ApiConstants.driverLicenseUploadEndPoint,
        {},
        multipartBody: multipartBody,
      );

      uploadGalleryLoading.value = false;
      update();

      if (response.statusCode == 200 || response.statusCode == 201) {
        imagePaths.assignAll(List.filled(2, ''));

        Future.delayed(const Duration(milliseconds: 500), () {
          if (!isUpdate) {
            Get.offAllNamed(AppRoutes.driverHomeScreen);
          } else {
            Get.back();
          }
        });
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      uploadGalleryLoading.value = false;
      update();
      Get.snackbar('Upload Error', e.toString());
    }
  }
}