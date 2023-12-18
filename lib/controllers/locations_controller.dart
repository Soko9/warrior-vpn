import "package:get/get.dart";
import "package:warrior_vpn/models/vpn_model.dart";
import "package:warrior_vpn/services/vpn_gate_api.dart";

class LocationsController extends GetxController {
  List<Vpn?> vpnServers = [];
  RxBool isLoading = false.obs;

  void retreiveAllServers() async {
    isLoading.value = true;
    vpnServers.clear();
    vpnServers = await VpnGateApi.retrieveVpnServers();
    isLoading.value = false;
  }
}
