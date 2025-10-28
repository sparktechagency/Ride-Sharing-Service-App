import 'package:logger/logger.dart';

showInfo(String message) {
  Logger logger = Logger();
  logger.i(message);
}

showWarning(String message) {
  Logger logger = Logger();
  logger.w(message);
}

showError(String message) {
  Logger logger = Logger();
  logger.e(message);
}

showDebug(String message) {
  Logger logger = Logger();
  logger.d(message);
}

