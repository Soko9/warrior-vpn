import "package:hive/hive.dart";

part "vpn_model.g.dart";

@HiveType(typeId: 0)
class Vpn {
  @HiveField(0)
  final String hostName;
  @HiveField(1)
  final String ip;
  @HiveField(2)
  final String countryName;
  @HiveField(3)
  final String countryCode;
  @HiveField(4)
  final int ping;
  @HiveField(5)
  final int speed;
  @HiveField(6)
  final int sessionNumber;
  @HiveField(7)
  final String openVpnConfigData;

  const Vpn({
    required this.hostName,
    required this.ip,
    required this.countryName,
    required this.countryCode,
    required this.ping,
    required this.speed,
    required this.sessionNumber,
    required this.openVpnConfigData,
  });

  factory Vpn.fromMap({required Map<String, dynamic> map}) => Vpn(
        hostName: map["HostName"] ?? "",
        ip: map["IP"] ?? "",
        countryName: map["CountryLong"] ?? "",
        countryCode: map["CountryShort"] ?? "",
        ping: int.tryParse(map["Ping"].toString()) ?? 0,
        speed: int.tryParse(map["Speed"].toString()) ?? 0,
        sessionNumber: int.tryParse(map["NumVpnSessions"].toString()) ?? 0,
        openVpnConfigData: map["OpenVPN_ConfigData_Base64"] ?? "",
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        "HostName": hostName,
        "IP": ip,
        "CountryLong": countryName,
        "CountryShort": countryCode,
        "Ping": ping,
        "Speed": speed,
        "NumVpnSessions": sessionNumber,
        "OpenVPN_ConfigData_Base64": openVpnConfigData,
      };
}
