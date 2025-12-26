import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controllers/privacy_terms_controller.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_text.dart';

class TermsServicesScreen extends StatefulWidget {
  const TermsServicesScreen({super.key});

  @override
  State<TermsServicesScreen> createState() => _TermsServicesScreenState();
}

class _TermsServicesScreenState extends State<TermsServicesScreen> {
  final PrivacyTermsController termsController = Get.isRegistered<PrivacyTermsController>()
      ? Get.find<PrivacyTermsController>()
      : Get.put(PrivacyTermsController(), permanent: true);

  @override
  void initState() {
    super.initState();
    termsController.fetchTermsConditions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.termsConditions.tr),
      body: Obx(() {
        if (termsController.isLoadingTermsConditions.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final content = termsController.getTermsConditionsContent();

        if (content.isEmpty) {
          return  Center(
            child: CustomText(
              text: 'No terms and conditions content available',
              fontSize: 16.sp,
            ),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: content,
                  fontSize: 14.sp,
                  textAlign: TextAlign.start,
                  // 1. Set maxLine to null to allow infinite expansion
                  maxLine: null,
                  // 2. Set textOverflow to visible so it doesn't add "..."
                  textOverflow: TextOverflow.visible,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
