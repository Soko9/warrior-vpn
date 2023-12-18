import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:warrior_vpn/controllers/home_controller.dart";
import "package:warrior_vpn/controllers/locations_controller.dart";
import "package:warrior_vpn/widgets/loaction_loading_shimmer.dart";
import "package:warrior_vpn/widgets/location_tile_widget.dart";

class LocationsScreen extends StatelessWidget {
  LocationsScreen({super.key});

  final LocationsController controller = Get.put(LocationsController());
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    if (controller.vpnServers.isEmpty) {
      controller.retreiveAllServers();
    }
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text("VPN Locations [${controller.vpnServers.length}]"),
          ),
          body: RefreshIndicator.adaptive(
            onRefresh: () async {
              controller.retreiveAllServers();
            },
            child: controller.isLoading.value
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (_, index) => LocationLoadingShimmer(
                      index: index,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    physics: const BouncingScrollPhysics(),
                  )
                : controller.vpnServers.isEmpty
                    ? const Center(
                        child: Text("No Servers Found..."),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.vpnServers.length,
                        itemBuilder: (_, index) => LocationTileWidget(
                          index: index,
                          server: controller.vpnServers[index]!,
                          onPress: () {
                            homeController.chooseServer(
                              server: controller.vpnServers[index]!,
                            );
                          },
                        ),
                        padding: const EdgeInsets.all(8.0),
                        physics: const BouncingScrollPhysics(),
                      ),
          ),
        ));
  }
}
