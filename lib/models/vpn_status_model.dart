class VpnStatus {
  final String byteIn;
  final String byteOut;
  final String duration;
  final String lastPacketRecieved;

  const VpnStatus({
    required this.byteIn,
    required this.byteOut,
    required this.duration,
    required this.lastPacketRecieved,
  });

  factory VpnStatus.fromMap({required Map<String, dynamic> map}) => VpnStatus(
        byteIn: map["byte_in"] as String,
        byteOut: map["byte_out"],
        duration: map["duration"],
        lastPacketRecieved: map["last_packet_receive"],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        "byte_in": byteIn,
        "byte_out": byteOut,
        "duration": duration,
        "last_packet_recieve": lastPacketRecieved,
      };
}
