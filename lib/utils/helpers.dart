import "dart:math";

import "package:flutter/material.dart";
import "package:get/get.dart";

import "colors.dart";

enum SnackType {
  warning,
  error,
  info,
}

class HELPERS {
  static void showSnakbar({
    required SnackType type,
    required String message,
  }) {
    Get.snackbar(
      "",
      "",
      titleText: const SizedBox(),
      messageText: ListTile(
        tileColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        minVerticalPadding: 0,
        leading: Container(
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(
                width: 3.0,
                color: COLORS.darkTextColor,
              ),
            ),
          ),
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            type.name.toUpperCase(),
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w900,
              color: COLORS.darkTextColor,
            ),
          ),
        ),
        title: Text(
          message.toUpperCase(),
          style: const TextStyle(
            fontSize: 14.0,
            color: COLORS.darkTextColor,
          ),
        ),
      ),
      animationDuration: const Duration(milliseconds: 450),
      backgroundGradient: LinearGradient(
        colors: type == SnackType.warning
            ? COLORS.warningGradient
            : type == SnackType.error
                ? COLORS.errorGradient
                : COLORS.infoGradient,
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      duration: const Duration(milliseconds: 5500),
      borderRadius: 6.0,
      overlayBlur: 8,
      barBlur: 0,
      backgroundColor: Colors.white,
      forwardAnimationCurve: Curves.easeInBack,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
        left: 16.0,
        right: 8.0,
      ),
      snackPosition: SnackPosition.TOP,
    );
  }

  static String getBandwidthSpeedUnit({required int speed, int decimals = 1}) {
    const List<String> units = ["Bps", "KBps", "MBps", "GBps"];
    if (speed <= 0) {
      return "0 ${units[0]}";
    }
    final int spd = (log(speed) / log(1024)).floor();
    return "${(speed / pow(1024, spd)).toStringAsFixed(decimals)} ${units[spd]}";
  }
}
