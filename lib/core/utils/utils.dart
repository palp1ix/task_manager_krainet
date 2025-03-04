import 'package:flutter/material.dart';
import 'package:task_manager_krainet/core/constants/constants.dart';
import 'package:task_manager_krainet/core/exeptions/exceptions.dart';

class AppUtils {
  static isBigScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > AppConstants.bigScreenWidthLimit;
  }

  // Function for handling reposnse with try-catch construction
  static T serverResponseHandler<T, E extends AppException>(
    T Function() closure, {
    required E Function(String message) exceptionBuilder,
  }) {
    try {
      return closure.call();
    } catch (e) {
      // Create and throw the specific exception type provided by the caller
      throw exceptionBuilder(e.toString());
    }
  }
}
