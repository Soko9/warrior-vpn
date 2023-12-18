class VpnConfig {
  final String username;
  final String password;
  final String countryName;
  final String configData;

  const VpnConfig({
    required this.username,
    required this.password,
    required this.countryName,
    required this.configData,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        "config": configData,
        "country": countryName,
        "username": username,
        "password": password,
      };
}
