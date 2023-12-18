class IP {
  final String country;
  final String region;
  final String city;
  final String zip;
  final (double, double) coordinates;
  final String timeZone;
  final String isp;
  final String query;

  IP({
    required this.country,
    required this.region,
    required this.city,
    required this.zip,
    required this.coordinates,
    required this.timeZone,
    required this.isp,
    required this.query,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        "country": country,
        "region": region,
        "city": city,
        "zip": zip,
        "lat": coordinates.$1,
        "lon": coordinates.$2,
        "timeZone": timeZone,
        "isp": isp,
        "query": query,
      };

  factory IP.fromMap({required Map<String, dynamic> map}) => IP(
        country: map["country"] ?? "",
        region: map["regionName"] ?? "",
        city: map["city"] ?? "",
        zip: map["zip"] ?? "",
        coordinates: (map["lat"] ?? 0.0, map["lon"] ?? 0.0),
        timeZone: map["timezone"] ?? "",
        isp: map["isp"] ?? "",
        query: map["query"] ?? "",
      );
}
