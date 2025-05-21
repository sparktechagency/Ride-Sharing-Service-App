import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ride_sharing/utils/app_colors.dart';

import '../../../../base/custom_text.dart';
import '../BottomNavBar/driver_bottom_menu..dart';
import 'InnerWidget/canceled_tab.dart';
import 'InnerWidget/completed_tab.dart';
import 'InnerWidget/current_trips_tab.dart';
import 'InnerWidget/my_ride_tab.dart';
import 'InnerWidget/ride_request_tab.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(() {});
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
            bottomNavigationBar: DriverBottomMenu(3),
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: CustomText(
                text: "My Orders",
                fontSize: 16.sp,
              ),
              centerTitle: true,
              bottom: TabBar(

                padding: EdgeInsets.zero,
                controller: _tabController,
                indicatorColor: AppColors.primaryColor,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  //========================> My Ride Tab <====================
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
                          text: 'My Ride',
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                  //========================> Ride Request Tab <====================
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
                          text: 'Ride Request',
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                  //========================> Current Trips Tab <====================
                  Tab(
                    child: Container(
                      width: 81.w,
                      decoration: BoxDecoration(
                        color: _tabController.index == 2
                            ? const Color(0xFFebf9ff)
                            : Colors.transparent,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: CustomText(
                          text: 'Current Trips',
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                  //========================> Canceled Tab <====================
                  Tab(
                    child: Container(
                      width: 81.w,
                      decoration: BoxDecoration(
                        color: _tabController.index == 3
                            ? const Color(0xFFebf9ff)
                            : Colors.transparent,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: CustomText(
                          text: 'Canceled',
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                  //========================> Completed Tab <====================
                  Tab(
                    child: Container(
                      width: 81.w,
                      decoration: BoxDecoration(
                        color: _tabController.index == 4
                            ? const Color(0xFFebf9ff)
                            : Colors.transparent,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: CustomText(
                          text: 'Completed',
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body:TabBarView(
              controller: _tabController,
              children:  [
                MyRideTab(),
                RideRequestTab(),
                CurrentTripsTab(),
                CanceledTab(),
                CompletedTab(),
              ],
            ))

    );
  }
}
