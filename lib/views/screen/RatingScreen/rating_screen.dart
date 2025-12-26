import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/controllers/get_rating_controller.dart';
import '../../../utils/app_colors.dart';
import '../../base/custom_text.dart';
import 'InnerWidget/given_tab.dart';
import 'InnerWidget/rating_tab.dart';
import 'InnerWidget/received_tab.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final GetRatingController ratingsController = Get.put(GetRatingController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);

    // Initial fetch for the first tab (Received -> author)
    ratingsController.fetchRatings(
      userId: "68fb1a370a8b4dde2cbcfcf2",
      type: "author",
    );
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;

    final type = _tabController.index == 0 ? "author" : "user";
    ratingsController.fetchRatings(
      userId: "68fb1a370a8b4dde2cbcfcf2",
      type: type,
    );
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: CustomText(
            text: "Rating".tr,
            fontSize: 16.sp,
          ),
          centerTitle: true,
          bottom: TabBar(
            padding: EdgeInsets.zero,
            controller: _tabController,
            indicatorColor: AppColors.primaryColor,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            isScrollable: true,
            tabs: [
              Tab(
                child: Container(
                  width: 81.w,
                  decoration: BoxDecoration(
                    color: _tabController.index == 0
                        ? const Color(0xFFebf9ff)
                        : Colors.transparent,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: CustomText(
                      text: 'Received'.tr,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  width: 81.w,
                  decoration: BoxDecoration(
                    color: _tabController.index == 1
                        ? const Color(0xFFebf9ff)
                        : Colors.transparent,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: CustomText(
                      text: 'Given'.tr,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Obx(
              () {
            if (ratingsController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            final data = ratingsController.ratingsResponse.value?.data.attributes;
            if (data == null) {
              return Center(child: Text("No ratings found".tr));
            }

            // Both tabs can use the same UI
            return TabBarView(
              controller: _tabController,
              children: [
                RatingTab(attributes: data),
                RatingTab(attributes: data),
              ],
            );
          },
        ),
      ),
    );
  }
}
