import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:warrior_vpn/controllers/home_controller.dart";
import "package:warrior_vpn/models/vpn_model.dart";
import "package:warrior_vpn/models/vpn_status_model.dart";
import "package:warrior_vpn/screens/locations_screen.dart";
import "package:warrior_vpn/services/hive_pref.dart";
import "package:warrior_vpn/services/vpn_engine.dart";
import "package:warrior_vpn/utils/colors.dart";
import "package:warrior_vpn/widgets/show_widget.dart";
import "package:warrior_vpn/widgets/vpn_button_widget.dart";

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    VpnEngine.vpnStageSnapshot().listen((event) {
      // print("event: $event");
      controller.connectionState.value = event;
    });

    void leadingPressed() {}

    void actionPressed() {
      Get.changeThemeMode(
        HivePref.darkMode ? ThemeMode.light : ThemeMode.dark,
      );
      HivePref.darkMode = !HivePref.darkMode;
    }

    void locationBarPressed() {
      Get.to(() => LocationsScreen());
    }

    void vpnPressed() {
      controller.connnectToVpn();
    }

    return Scaffold(
      appBar: _appBar(leadingPressed, actionPressed),
      bottomNavigationBar: _locationBar(locationBarPressed, context),
      body: _body(vpnPressed),
    );
  }

  Padding _body(void Function() vpnPressed) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() {
            final Vpn vpn = controller.vpn.value;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShowWidget(
                  label: vpn.countryName.isEmpty
                      ? "--"
                      : vpn.countryName.endsWith("of")
                          ? vpn.countryName
                              .substring(0, vpn.countryName.length - 3)
                          : vpn.countryName,
                  icon: vpn.countryName.isEmpty
                      ? Icons.location_on_rounded
                      : null,
                  image: vpn.countryName.isEmpty
                      ? null
                      : "assets/flags/${vpn.countryCode.toLowerCase()}.png",
                  color: Get.isDarkMode
                      ? COLORS.darkCountryColor
                      : COLORS.lightCountryColor,
                ),
                ShowWidget(
                  label: vpn.countryName.isEmpty ? "--" : "${vpn.ping} ms",
                  icon: Icons.signal_cellular_alt_rounded,
                  color: Get.isDarkMode
                      ? COLORS.darkPingColor
                      : COLORS.lightPingColor,
                ),
              ],
            );
          }),
          Obx(
            () => VPNButtonWidget(
              onPress: vpnPressed,
              color: controller.buttonColor,
              child: controller.buttonChild,
            ),
          ),
          StreamBuilder<VpnStatus>(
              stream: VpnEngine.vpnStatusSnapshot(),
              builder: (context, snapshot) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShowWidget(
                      label: snapshot.data != null
                          ? "${snapshot.data?.byteIn}"
                          : "--",
                      icon: Icons.download_rounded,
                      color: Get.isDarkMode
                          ? COLORS.darkDownloadColor
                          : COLORS.lightDownloadColor,
                    ),
                    ShowWidget(
                      label: snapshot.data != null
                          ? "${snapshot.data?.byteOut}"
                          : "--",
                      icon: Icons.upload_rounded,
                      color: Get.isDarkMode
                          ? COLORS.darkUploadColor
                          : COLORS.lightUploadColor,
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }

  Widget _locationBar(
    void Function() locationBarPressed,
    BuildContext context,
  ) {
    return SafeArea(
      child: Semantics(
        button: true,
        child: InkWell(
          onTap: locationBarPressed,
          child: ListTile(
            leading: const Icon(Icons.flag_rounded),
            iconColor: Theme.of(context).colorScheme.tertiary,
            tileColor: Theme.of(context).colorScheme.tertiaryContainer,
            title: const FittedBox(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "select country or location",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ),
            contentPadding: const EdgeInsets.all(4.0),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
          ),
        ),
      ),
    );
  }

  AppBar _appBar(
    void Function() leadingPressed,
    void Function() actionPressed,
  ) {
    return AppBar(
      title: const Text("Warrior VPN"),
      leading: IconButton(
        onPressed: leadingPressed,
        icon: const Icon(Icons.perm_device_information),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            onPressed: actionPressed,
            icon: const Icon(
              Icons.dark_mode_rounded,
            ),
          ),
        ),
      ],
    );
  }
}
