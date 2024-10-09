import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TDeviceUtils {
  static double getAppBarHeight() {
    return kToolbarHeight;
  }

  static double getBottomNavigationBarHeight() {
    return kBottomNavigationBarHeight;
  }

  static double getStatusBarHeight() {
    return MediaQuery.of(Get.context!).padding.top;
  }
}
