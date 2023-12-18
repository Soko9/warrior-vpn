import "dart:convert";

import "package:flutter/services.dart";
import "package:warrior_vpn/models/vpn_config_model.dart";
import "package:warrior_vpn/models/vpn_status_model.dart";

class VpnEngine {
  // native event channels
  static const String eventChannelVpnStage = "vpnStage";
  static const String eventChannelVpnStatus = "vpnStatus";
  static const String eventChannelVpnControl = "vpnControl";

  // vpn status
  static const String vpnConnected = "connected";
  static const String vpnDisconnected = "disconnected";
  static const String vpnReconnected = "reconnect";
  static const String vpnNoConnection = "no_connection";
  static const String vpnConnecting = "connecting";
  static const String vpnWaiting = "wait_connection";
  static const String vpnAuthenticating = "authenticating";
  static const String vpnPreparing = "prepare";
  static const String vpnDenied = "denied";

  // connection stage snapshot
  static Stream<String> vpnStageSnapshot() =>
      const EventChannel(eventChannelVpnStage).receiveBroadcastStream().cast();

  // connection status snapshot
  static Stream<VpnStatus> vpnStatusSnapshot() =>
      const EventChannel(eventChannelVpnStatus)
          .receiveBroadcastStream()
          .map((event) => VpnStatus.fromMap(map: jsonDecode(event)))
          .cast();

  // start vpn engine
  static Future startVpnEngine({required VpnConfig vpnConfig}) async =>
      const MethodChannel(eventChannelVpnControl).invokeMethod(
        "start",
        vpnConfig.toMap(),
      );

  // stop vpn engine
  static Future stopVpnEngine() async =>
      const MethodChannel(eventChannelVpnControl).invokeMethod("stop");

  // kill switch
  static Future killSwitch() async =>
      const MethodChannel(eventChannelVpnControl).invokeMethod("kill_switch");

  // refresh
  static Future refresh() async =>
      const MethodChannel(eventChannelVpnControl).invokeMethod("refresh");

  // get stage
  static Future<String?> getStage() async =>
      const MethodChannel(eventChannelVpnControl).invokeMethod("stage");

  // isConnected
  static Future<bool> isConnected() async =>
      getStage().then((value) => value!.toLowerCase() == "connected");
}
