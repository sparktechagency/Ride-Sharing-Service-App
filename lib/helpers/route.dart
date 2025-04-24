import 'package:get/get.dart';
import '../views/screen/Auth/ForgotPass/forgot_password_screen.dart';
import '../views/screen/Auth/OtpScreen/otp_screen.dart';
import '../views/screen/Auth/ResetPass/reset_password_screen.dart';
import '../views/screen/Auth/SignIn/sign_in_screen.dart';
import '../views/screen/Auth/SignUp/sign_up_screen.dart';
import '../views/screen/Auth/SignUp/sign_up_three_screen.dart';
import '../views/screen/Auth/SignUp/sign_up_two_screen.dart';
import '../views/screen/Categories/categories_screen.dart';
import '../views/screen/Location/location_picker_screen.dart';
import '../views/screen/Location/location_screen.dart';
import '../views/screen/Profile/profile_screen.dart';
import '../views/screen/Role/Driver/Home/home_screen.dart';
import '../views/screen/SelectRole/select_role_screen.dart';
import '../views/screen/Splash/onboarding_screen.dart';
import '../views/screen/Splash/splash_screen.dart';

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
  static String homeScreen="/home_screen";
  static String profileScreen="/profile_screen";
  static String categoriesScreen="/categories_screen";
  static String locationScreen="/location_screen";
  static String locationPickerScreen="/location_picker_screen";

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
    GetPage(name:homeScreen, page: ()=>const HomeScreen(),transition:Transition.noTransition),
    GetPage(name:categoriesScreen, page: ()=>const CategoriesScreen(),transition:Transition.noTransition),
    GetPage(name:profileScreen, page: ()=>const ProfileScreen(),transition: Transition.noTransition),
   // GetPage(name:locationScreen, page: ()=>const LocationScreen(),transition: Transition.noTransition),
   // GetPage(name:locationPickerScreen, page: ()=>const LocationPickerScreen(),transition: Transition.noTransition),
  ];
}