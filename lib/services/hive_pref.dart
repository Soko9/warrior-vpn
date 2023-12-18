import "package:hive_flutter/hive_flutter.dart";
import "package:warrior_vpn/models/vpn_model.dart";
import "package:path_provider/path_provider.dart";

class HivePref {
  static late Box boxData;
  static late Box boxServers;

  static Future<void> initHive() async {
    final docDir = await getApplicationDocumentsDirectory();
    Hive.init(docDir.path);
    Hive.registerAdapter(VpnAdapter());
    boxData = await Hive.openBox("boxData");
    boxServers = await Hive.openBox("boxServers");
  }

  // theme option
  static set darkMode(bool value) => boxData.put("darkMode", value);
  static bool get darkMode => boxData.get("darkMode") ?? false;

  // vpn info
  static putServer({required Vpn? vpn}) => boxServers.add(vpn);
  static Vpn? getServer({required int index}) => boxServers.getAt(index);

  // vpn list
  static putServers({required List<Vpn?> vpns}) => boxServers.addAll(vpns);

  static List<Vpn?> getServers() => boxServers.values.cast<Vpn>().toList();
}
