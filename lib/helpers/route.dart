import 'package:get/get.dart';
import '../views/screen/AboutUs/about_us_screen.dart';
import '../views/screen/Auth/ChangePass/change_password_screen.dart';
import '../views/screen/Auth/ForgotPass/forgot_password_screen.dart';
import '../views/screen/Auth/OtpScreen/otp_screen.dart';
import '../views/screen/Auth/ResetPass/reset_password_screen.dart';
import '../views/screen/Auth/SignIn/sign_in_screen.dart';
import '../views/screen/Auth/SignUp/sign_up_screen.dart';
import '../views/screen/Auth/SignUp/sign_up_three_screen.dart';
import '../views/screen/Auth/SignUp/sign_up_two_screen.dart';
import '../views/screen/Location/location_picker_screen.dart';
import '../views/screen/Location/location_screen.dart';
import '../views/screen/Notifications/notifications_screen.dart';
import '../views/screen/PrivacyPolicy/privacy_policy_screen.dart';
import '../views/screen/Profile/profile_screen.dart';
import '../views/screen/Role/Driver/Home/InnerScreen/recent_order_screen.dart';
import '../views/screen/Role/Driver/Home/driver_home_screen.dart';
import '../views/screen/Role/Driver/Inbox/MessageInbox/driver_message_screen.dart';
import '../views/screen/Role/Driver/Inbox/driver_inbox_screen.dart';
import '../views/screen/Role/Driver/MyOrders/my_orders_screen.dart';
import '../views/screen/Role/Driver/MyWallet/my_wallet_screen.dart';
import '../views/screen/Role/Driver/PostRides/post_rides_screen.dart';
import '../views/screen/Role/Driver/Profile/EditProfileInfro/driver_edit_profile_screen.dart';
import '../views/screen/Role/Driver/Profile/PersonalInformation/driver_personal_information_screen.dart';
import '../views/screen/Role/Driver/Profile/driver_profile_screen.dart';
import '../views/screen/SelectRole/select_role_screen.dart';
import '../views/screen/Settings/settings_screen.dart';
import '../views/screen/Splash/onboarding_screen.dart';
import '../views/screen/Splash/splash_screen.dart';
import '../views/screen/Support/support_screen.dart';
import '../views/screen/TermsofServices/terms_services_screen.dart';

class AppRoutes{
  static String splashScreen="/splash_screen";
  static String onboardingScreen="/onboarding_screen";
  static String selectRoleScreen="/select_role_screen";
  static String signUpScreen="/sign_up_screen";
  static String signUpTwoScreen="/sign_up_two_screen";
  static String signUpThreeScreen="/sign_up_three_screen";
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
  //===================================================> Driver Role <=============================================
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

 static List<GetPage> page=[
    GetPage(name:splashScreen, page: ()=>const SplashScreen()),
    GetPage(name:onboardingScreen, page: ()=>const OnboardingScreen()),
    GetPage(name:selectRoleScreen, page: ()=>const SelectRoleScreen()),
    GetPage(name:signUpScreen, page: ()=>const SignUpScreen()),
    GetPage(name:signUpTwoScreen, page: ()=> SignUpTwoScreen()),
    GetPage(name:signUpThreeScreen, page: ()=> SignUpThreeScreen()),
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
   //===================================================> Driver Role <=============================================
   GetPage(name:driverHomeScreen, page: ()=>const DriverHomeScreen(),transition:Transition.noTransition),
   GetPage(name:postRidesScreen, page: ()=>const PostRidesScreen(),transition:Transition.noTransition),
   GetPage(name:driverInboxScreen, page: ()=> DriverInboxScreen(),transition:Transition.noTransition),
   GetPage(name:myOrdersScreen, page: ()=> MyOrdersScreen(),transition:Transition.noTransition),
    GetPage(name:driverProfileScreen, page: ()=>const DriverProfileScreen(),transition: Transition.noTransition),
    GetPage(name:driverMessageScreen, page: ()=>const DriverMessageScreen()),
    GetPage(name:driverPersonalInformationScreen, page: ()=>const DriverPersonalInformationScreen()),
    GetPage(name:driverEditProfileScreen, page: ()=>const DriverEditProfileScreen()),
    GetPage(name:myWalletScreen, page: ()=>const MyWalletScreen()),
    GetPage(name:recentOrderScreen, page: ()=>const RecentOrderScreen()),
   // GetPage(name:locationScreen, page: ()=>const LocationScreen(),transition: Transition.noTransition),
   // GetPage(name:locationPickerScreen, page: ()=>const LocationPickerScreen(),transition: Transition.noTransition),
  ];
}