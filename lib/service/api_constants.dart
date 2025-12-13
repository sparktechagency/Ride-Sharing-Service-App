class ApiConstants {
  static const String baseUrl = "https://faysal5500.sobhoy.com/api/v1";
  static const String imageBaseUrl = "https://faysal5500.sobhoy.com";
  static const String signUpEndPoint = "/auth/register";
  static const String otpEndPoint = "/auth/verify-email";
  static const String signInEndPoint = "/auth/login";
  static const String forgotPassEndPoint = "/auth/forgot-password";
  static const String resetPassEndPoint = "/auth/reset-password";
  static const String changePassEndPoint = "/auth/change-password";
  static const String getPersonalInfoEndPoint = "/users/self/in";
  static const String setLocationEndPoint = "";
  static const String termsConditionEndPoint = "";
  static const String privacyPolicyEndPoint = "";
  static const String aboutUsEndPoint = "";
  //==========================================> Driver Role <=======================
  static const String driverLicenseUploadEndPoint = "/users/self/post-image-liscense";
  static const String homePageStatisticsEndPoint = "/home/statistics";



//==========================================> User Role <=======================
  static const String getBookingUserDetails = "/booking/get-user-details/";
  static const String getBookingByStatus = "/booking/get/";


}
