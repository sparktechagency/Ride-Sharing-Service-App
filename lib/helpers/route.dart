// ignore_for_file: unused_import

import 'package:get/get.dart';
import 'package:ride_sharing/views/screen/Role/Driver/MyOrders/InnerWidget/single_ride_details_screen.dart';
import 'package:ride_sharing/views/screen/Role/Driver/rider_post_submit/rider_post_submit.dart';
import '../views/screen/AboutUs/about_us_screen.dart';
import '../views/screen/ActiveOrderDetails/active_order_details.dart';
import '../views/screen/Auth/ChangePass/change_password_screen.dart';
import '../views/screen/Auth/DriverSignUp/driver_sign_up_screen.dart';
import '../views/screen/Auth/DriverSignUp/driver_licence_upload_screen.dart';
import '../views/screen/Auth/DriverSignUp/driver_sign_up_two_screen.dart';
import '../views/screen/Auth/ForgotPass/forgot_password_screen.dart';
import '../views/screen/Auth/OtpScreen/otp_screen.dart';
import '../views/screen/Auth/ResetPass/reset_password_screen.dart';
import '../views/screen/Auth/SignIn/sign_in_screen.dart';
import '../views/screen/Auth/UserSignUp/user_sign_up_screen.dart';
import '../views/screen/CanceledOrderDetails/canceled_order_details.dart';
import '../views/screen/CompletedOrderDetails/completed_order_details.dart';
import '../views/screen/Location/location_picker_screen.dart';
import '../views/screen/Location/location_screen.dart';
import '../views/screen/Notifications/notifications_screen.dart';
import '../views/screen/PrivacyPolicy/privacy_policy_screen.dart';
import '../views/screen/RatingScreen/rating_screen.dart';
import '../views/screen/Role/Driver/AddCity/add_city_screen.dart';
import '../views/screen/Role/Driver/CityView/city_view_screen.dart';
import '../views/screen/Role/Driver/DropOff/drop_off_screen.dart';
import '../views/screen/Role/Driver/Home/InnerScreen/active_order_screen.dart';
import '../views/screen/Role/Driver/Home/InnerScreen/completed_order_screen.dart';
import '../views/screen/Role/Driver/Home/InnerScreen/recent_order_screen.dart';
import '../views/screen/Role/Driver/Home/driver_home_screen.dart';
import '../views/screen/Role/Driver/Inbox/MessageInbox/driver_message_screen.dart';
import '../views/screen/Role/Driver/Inbox/driver_inbox_screen.dart';
import '../views/screen/Role/Driver/MyOrders/my_orders_screen.dart';
import '../views/screen/Role/Driver/MyRide/driver_my_ride_screen.dart';
import '../views/screen/Role/Driver/MyWallet/my_wallet_screen.dart';
import '../views/screen/Role/Driver/PassengersTake/passengers_take_screen.dart';
import '../views/screen/Role/Driver/PickUp/pick_up_screen.dart';
import '../views/screen/Role/Driver/PostRides/post_rides_screen.dart';
import '../views/screen/Role/Driver/Profile/EditProfileInfro/driver_edit_profile_screen.dart';
import '../views/screen/Role/Driver/Profile/PersonalInformation/driver_personal_information_screen.dart';
import '../views/screen/Role/Driver/Profile/driver_profile_screen.dart';
import '../views/screen/Role/User/Inbox/MessageInbox/user_message_screen.dart';
import '../views/screen/Role/User/Inbox/user_inbox_screen.dart';
import '../views/screen/Role/User/MyRides/my_rides_screen.dart';
import '../views/screen/Role/User/Profile/EditProfileInfro/user_edit_profile_screen.dart';
import '../views/screen/Role/User/Profile/PersonalInformation/user_personal_information_screen.dart';
import '../views/screen/Role/User/Profile/user_profile_screen.dart';
import '../views/screen/Role/User/Search/InnerScreen/ride_details_screen.dart';
import '../views/screen/Role/User/Search/InnerScreen/see_all_screen.dart';
import '../views/screen/Role/User/Search/user_search_screen.dart';
import '../views/screen/SelectRole/select_role_screen.dart';
import '../views/screen/Settings/settings_screen.dart';
import '../views/screen/Splash/onboarding_screen.dart';
import '../views/screen/Splash/splash_screen.dart';
import '../views/screen/Support/support_screen.dart';
import '../views/screen/TermsofServices/terms_services_screen.dart';
import '../views/screen/TotalUser/total_user_screen.dart';

class AppRoutes{
  static String splashScreen="/splash_screen";
  static String onboardingScreen="/onboarding_screen";
  static String selectRoleScreen="/select_role_screen";
  static String signInScreen="/sign_in_screen";
  static String otpScreen="/otp_screen";
  static String forgotPasswordScreen="/forgot_password_screen";
  static String resetPasswordScreen="/reset_password_screen";
  static String changePasswordScreen="/change_password_screen";
  static String settingsScreen="/settings_screen";
  static String aboutUsScreen="/about_us_screen";
  static String supportScreen="/support_screen";
  static String privacyPolicyScreen="/privacy_policy_screen";
  static String termsServicesScreen="/terms_services_screen";
  static String notificationsScreen="/notifications_screen";
  static String activeOrderDetails="/active_order_details";
  static String completedOrderDetails="/completed_order_details";
  static String canceledOrderDetails="/canceled_order_details";
  static String ratingScreen="/rating_screen";
  static String totalUserScreen="/total_screen_screen";
  //===================================================> Driver Role <=============================================
  static String driverSignUpScreen="/driver_sign_up_screen";
  static String driverSignUpTwoScreen="/driver_sign_up_two_screen";
  static String driverLicenceUploadScreen="/driver_licence_upload_screen";
  static String driverHomeScreen="/driver_home_screen";
  static String postRidesScreen="/post_rides_screen";
  static String driverInboxScreen="/driver_inbox_screen";
  static String myOrdersScreen="/my_order_screen";
  static String driverMessageScreen="/driver_message_screen";
  static String driverProfileScreen="/driver_profile_screen";
  static String driverPersonalInformationScreen="/driver_personal_information_screen";
  static String driverEditProfileScreen="/driver_edit_profile_screen";
  static String locationScreen="/location_screen";
  static String locationPickerScreen="/location_picker_screen";
  static String myWalletScreen="/my_wallet_screen";
  static String recentOrderScreen="/recent_order_screen";
  static String activeOrderScreen="/active_order_screen";
  static String completedOrderScreen="/completed_order_screen";
  static String pickUpScreen="/pick_up_screen";
  static String dropOffScreen="/drop_off_screen";
  static String addCityScreen="/add_city_screen";
  static String cityViewScreen="/city_view_screen";
  static String passengersTakeScreen="/passengers_take_screen";
  static String driverMyRideScreen="/driver_my_ride_screen";
  static String riderPostSubmit="/rider_post_submit";
  //===================================================> User Role <=============================================
  static String userSignUpScreen="/user_sign_up_screen";
  static String userSearchScreen="/user_search_screen";
  static String userProfileScreen="/user_profile_screen";
  static String userEditProfileScreen="/user_edit_profile_screen";
  static String userPersonalInformationScreen="/user_personal_information_screen";
  static String userInboxScreen="/user_inbox_screen";
  static String userMessageScreen="/user_message_screen";
  static String myRidesScreen="/my_rides_screen";
  static String seeAllScreen="/see_all_screen";
  static String rideDetailsScreen="/ride_details_screen";
  static String singleRideDetailsScreen="/single_ride_details_screen";


 static List<GetPage> page=[
    GetPage(name:splashScreen, page: ()=>const SplashScreen()),
    GetPage(name:onboardingScreen, page: ()=>const OnboardingScreen()),
    GetPage(name:selectRoleScreen, page: ()=>const SelectRoleScreen()),
    GetPage(name:signInScreen, page: ()=> SignInScreen()),
    GetPage(name:otpScreen, page: ()=> OtpScreen()),
    GetPage(name:forgotPasswordScreen, page: ()=> ForgotPasswordScreen()),
    GetPage(name:resetPasswordScreen, page: ()=> ResetPasswordScreen()),
    GetPage(name:changePasswordScreen, page: ()=> ChangePasswordScreen()),
    GetPage(name:settingsScreen, page: ()=> SettingsScreen()),
    GetPage(name:aboutUsScreen, page: ()=> AboutUsScreen()),
    GetPage(name:supportScreen, page: ()=> SupportScreen()),
    GetPage(name:privacyPolicyScreen, page: ()=> PrivacyPolicyScreen()),
    GetPage(name:termsServicesScreen, page: ()=> TermsServicesScreen()),
    GetPage(name:notificationsScreen, page: ()=> NotificationsScreen()),
    GetPage(name:activeOrderDetails, page: ()=> ActiveOrderDetails()),
    GetPage(name:completedOrderDetails, page: ()=> CompletedOrderDetails()),
    GetPage(name:canceledOrderDetails, page: ()=> CanceledOrderDetails()),
    GetPage(name:ratingScreen, page: ()=> RatingScreen()),
    GetPage(name:totalUserScreen, page: ()=> TotalUserScreen()),
    //----------------------------------------//
   GetPage(name:locationScreen, page: ()=>const LocationScreen(),transition: Transition.noTransition),
   GetPage(name:locationPickerScreen, page: ()=>const LocationPickerScreen(),transition: Transition.noTransition),
   //===================================================> Driver Role <=============================================
   GetPage(name:driverSignUpScreen, page: ()=>const DriverSignUpScreen()),
   GetPage(name:driverSignUpTwoScreen, page: ()=> DriverSignUpTwoScreen()),
   GetPage(name:driverLicenceUploadScreen, page: ()=> DriverLicenceUploadScreen()),
   GetPage(name:driverHomeScreen, page: ()=> DriverHomeScreen(),transition:Transition.noTransition),
   GetPage(name:postRidesScreen, page: ()=> PostRidesScreen(),transition:Transition.noTransition),
   GetPage(name:driverInboxScreen, page: ()=> DriverInboxScreen(),transition:Transition.noTransition),
   GetPage(name:myOrdersScreen, page: ()=> MyOrdersScreen(),transition:Transition.noTransition),
    GetPage(name:driverProfileScreen, page: ()=> DriverProfileScreen(),transition: Transition.noTransition),
    GetPage(name:driverMessageScreen, page: ()=>const DriverMessageScreen()),
    GetPage(name:driverPersonalInformationScreen, page: ()=>const DriverPersonalInformationScreen()),
    GetPage(name:driverEditProfileScreen, page: ()=>const DriverEditProfileScreen()),
    GetPage(name:myWalletScreen, page: ()=>const MyWalletScreen()),
    GetPage(name:recentOrderScreen, page: ()=>const RecentOrderScreen()),
    GetPage(name:activeOrderScreen, page: ()=>const ActiveOrderScreen()),
    GetPage(name:completedOrderScreen, page: ()=>const CompletedOrderScreen()),
    GetPage(name:pickUpScreen, page: ()=> PickUpScreen()),
    // GetPage(name:dropOffScreen, page: ()=> DropOffScreen()),
    GetPage(name:addCityScreen, page: ()=> AddCityScreen()),
    GetPage(name:cityViewScreen, page: ()=> CityViewScreen()),
   GetPage(name:passengersTakeScreen, page: ()=> PassengersTakeScreen()),
   GetPage(name:driverMyRideScreen, page: ()=> DriverMyRideScreen()),
   GetPage(name: riderPostSubmit, page: ()=> RiderPostSubmit()),
   //===================================================> User Role <=============================================
   GetPage(name:userSignUpScreen, page: ()=> UserSignUpScreen()),
   GetPage(name:userSearchScreen, page: ()=> UserSearchScreen(),transition: Transition.noTransition),
   GetPage(name:myRidesScreen, page: ()=> MyRidesScreen(),transition: Transition.noTransition),
   GetPage(name:userInboxScreen, page: ()=> UserInboxScreen(),transition: Transition.noTransition),
   GetPage(name:userProfileScreen, page: ()=> UserProfileScreen(),transition: Transition.noTransition),
   GetPage(name:userEditProfileScreen, page: ()=> UserEditProfileScreen()),
   GetPage(name:userPersonalInformationScreen, page: ()=> UserPersonalInformationScreen()),
   GetPage(name:userMessageScreen, page: ()=> UserMessageScreen()),
   GetPage(name:seeAllScreen, page: ()=> SeeAllScreen()),
   GetPage(name:rideDetailsScreen, page: ()=> RideDetailsScreen()),
   GetPage(
     name: singleRideDetailsScreen,
     page: () => SingleRideDetailsScreen(rideId: Get.arguments as String),
   ),

 ];
}