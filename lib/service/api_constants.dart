class ApiConstants {
  static const String googleApiKey = "AIzaSyCrmEOP4JyFCozu7n85BIZqn_8LarJq_iI";
  static const String socketBaseUrl = "https://faysal6100.sobhoy.com";
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
  static const String termsConditionEndPoint = "/admin/get-terms-conditions";
  static const String privacyPolicyEndPoint = "/admin/get-privacy-policy";
  static const String aboutUsEndPoint = "";
  //==========================================> Driver Role <=======================
  static const String driverLicenseUploadEndPoint = "/users/self/post-image-liscense";
  static const String homePageStatisticsEndPoint = "/home/statistics";
  static const String createRide = "/ride/create";
  static const String driverStatusRides = "/home/orders/";
  static const String driverSingleRideDetails = "/ride/get-details/";
  static const String driverRideStatusUpdate = "/ride/update/";
  static const String driverRoomCreate = "/rooms/create";
  static const String getRecentOrder = "/booking/get-recent";
  static const String driverWalletDetails = "/home/my-wallet";





//==========================================> User Role <=======================
  static const String getBookingUserDetails = "/booking/get-user-details/";
  static const String getBookingByStatus = "/booking/get/";
  static const String createRating = "/rating/create";
  static const String searchRide = "/ride/search-ride";


  //==========================================> Common <=======================

  static const String getMessageRoomEndPoint = "/rooms/get";
  static const String getMessage = "/message/get/";
  static const String createMessage = "/message/create";
  static const String deleteMessage = "/message/delete/";
  static const String deleteConverstaion = "/rooms/delete/";
  static const String updateStatus = "/booking/update/";
  static const String createBooking = "/booking/create";
  static const String updateProfileData = "/users/self/update";
  static const String getRecent = "/rating/get/";
  static const String withdrawRequest = "/transaction/create";


}
