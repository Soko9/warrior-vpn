import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:warrior_vpn/screens/home_screen.dart";
import "package:warrior_vpn/services/hive_pref.dart";
import "package:warrior_vpn/utils/themes.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HivePref.initHive();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Warrior VPN",
      debugShowCheckedModeBanner: false,
      theme: THEMES.lightTheme,
      darkTheme: THEMES.darkTheme,
      themeMode: HivePref.darkMode ? ThemeMode.dark : ThemeMode.light,
      home: HomeScreen(),
    );
  }
}
