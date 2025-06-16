import '../models/language_model.dart';

class AppConstants{

  static String APP_NAME = "Ride-Sharing";
  static String fcmToken = "fcmToken";


  static const String bearerToken = "BearerToken";
  static const String phoneNumber = "PhoneNumber";
  static String isLogged = "IsLogged";
  static String id = "id";

  // share preference Key
  static String THEME ="theme";

  static const String LANGUAGE_CODE = 'language_code';
  static const String COUNTRY_CODE = 'country_code';

  static RegExp emailValidator = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static RegExp passwordValidator = RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"
  );
  static List<LanguageModel> languages = [
    LanguageModel( languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel( languageName: 'Spanish', countryCode: 'ES', languageCode: 'es'),
  ];
}