import "dart:convert";

import "package:csv/csv.dart";
import "package:warrior_vpn/models/ip_model.dart";
import "package:warrior_vpn/models/vpn_model.dart";
import "package:warrior_vpn/services/hive_pref.dart";
import "package:warrior_vpn/utils/helpers.dart";
import "package:http/http.dart" as http;

class VpnGateApi {
  static String _convertToCSV({required String source}) {
    String output = "";
    try {
      output = source.split("#")[1].replaceAll("*", "");
    } catch (e) {
      HELPERS.showSnakbar(type: SnackType.error, message: e.toString());
    }
    return output;
  }

  static List<Vpn> _getListFromData({required String csv}) {
    final List<Vpn> output = [];
    try {
      final List<dynamic> dataList = const CsvToListConverter().convert(csv);
      final List<dynamic> header = dataList[0];
      final List<dynamic> body = dataList.sublist(1, 21);

      for (var item in body) {
        Map<String, dynamic> data = {};
        for (int i = 0; i < header.length; i++) {
          data[header[i].toString()] = item[i].toString();
        }
        if (data["CountryLong"].toString().toLowerCase() == "israel") {
          continue;
        }
        output.add(Vpn.fromMap(map: data));
      }
    } catch (e) {
      HELPERS.showSnakbar(type: SnackType.error, message: "E: $e");
    }
    return output;
  }

  static Future<List<Vpn>> retrieveVpnServers() async {
    List<Vpn> vpns = [];
    try {
      final http.Response response = await http.get(
        Uri.parse("http://www.vpngate.net/api/iphone/"),
      );
      String csvString = _convertToCSV(source: response.body);
      vpns = _getListFromData(csv: csvString);
    } catch (e) {
      HELPERS.showSnakbar(type: SnackType.error, message: "e: $e");
    }

    vpns.shuffle();

    if (vpns.isNotEmpty) {
      HivePref.putServers(vpns: vpns);
    }

    return vpns;
  }

  static Future<IP?> retrieveIPInfo() async {
    try {
      final http.Response response = await http.get(
        Uri.parse("http://ip-api.com/json/"),
      );
      final Map<String, dynamic> data = jsonDecode(response.body);
      IP ip = IP.fromMap(map: data);
      return ip;
    } catch (e) {
      HELPERS.showSnakbar(type: SnackType.error, message: e.toString());
    }
    return null;
  }
}
