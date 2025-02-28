import 'package:flutter/material.dart';
import 'package:task_manager_krainet/core/constants/constants.dart';

class AppUtils {
  static isBigScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > AppConstants.bigScreenWidthLimit;
  }
}
