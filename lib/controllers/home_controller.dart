import "dart:convert";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:get/get.dart";
import "package:warrior_vpn/models/vpn_config_model.dart";
import "package:warrior_vpn/models/vpn_model.dart";
import "package:warrior_vpn/services/hive_pref.dart";
import "package:warrior_vpn/services/vpn_engine.dart";
import "package:warrior_vpn/utils/colors.dart";
import "package:warrior_vpn/utils/helpers.dart";

class HomeController extends GetxController {
  final Rx<Vpn> vpn = const Vpn(
    hostName: "",
    ip: "",
    countryName: "",
    countryCode: "",
    ping: 0,
    speed: 0,
    sessionNumber: 0,
    openVpnConfigData: "",
  ).obs;
  final Rx<String> connectionState = VpnEngine.vpnDisconnected.obs;

  Color get buttonColor {
    switch (connectionState.value) {
      case VpnEngine.vpnConnected:
        return Get.isDarkMode
            ? COLORS.darkConnectedColor
            : COLORS.lightConnectedColor;
      case VpnEngine.vpnDisconnected:
        return Get.isDarkMode
            ? COLORS.darkDisconnectedColor
            : COLORS.lightDisconnectedColor;
      default:
        return Get.isDarkMode
            ? COLORS.darkConnectingColor
            : COLORS.lightConnectingColor;
    }
  }

  Widget get buttonChild {
    switch (connectionState.value) {
      case VpnEngine.vpnConnected:
        return Text(
          "Connected",
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            color:
                Get.isDarkMode ? COLORS.darkTextColor : COLORS.lightTextColor,
          ),
        );
      case VpnEngine.vpnDisconnected:
        return Text(
          "Disconnected",
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            color:
                Get.isDarkMode ? COLORS.darkTextColor : COLORS.lightTextColor,
          ),
        );
      default:
        return Image.asset("assets/loader.gif");
    }
  }

  Future connnectToVpn() async {
    if (vpn.value.openVpnConfigData.isEmpty) {
      HELPERS.showSnakbar(
        type: SnackType.error,
        message: "Configuration Failed...",
      );
      return;
    }

    // if disconnected
    if (connectionState.value == VpnEngine.vpnDisconnected) {
      final Uint8List configUint = const Base64Decoder().convert(
        vpn.value.openVpnConfigData,
      );
      final configUtf = const Utf8Decoder().convert(configUint);
      final VpnConfig vpnConfig = VpnConfig(
        username: "vpn",
        password: "vpn",
        countryName: vpn.value.countryName,
        configData: configUtf,
      );

      await VpnEngine.startVpnEngine(vpnConfig: vpnConfig);
    } else {
      await VpnEngine.stopVpnEngine();
    }
  }

  void chooseServer({required Vpn server}) {
    HivePref.putServer(vpn: server);
    vpn.value = server;

    if (connectionState.value == VpnEngine.vpnConnected) {
      VpnEngine.stopVpnEngine();
      Future.delayed(const Duration(seconds: 2));
    }
    connnectToVpn();

    Get.back();
  }
}
