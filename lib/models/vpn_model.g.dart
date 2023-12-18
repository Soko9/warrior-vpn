// GENERATED CODE - DO NOT MODIFY BY HAND

part of "vpn_model.dart";

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VpnAdapter extends TypeAdapter<Vpn> {
  @override
  final int typeId = 0;

  @override
  Vpn read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Vpn(
      hostName: fields[0] as String,
      ip: fields[1] as String,
      countryName: fields[2] as String,
      countryCode: fields[3] as String,
      ping: fields[4] as int,
      speed: fields[5] as int,
      sessionNumber: fields[6] as int,
      openVpnConfigData: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Vpn obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.hostName)
      ..writeByte(1)
      ..write(obj.ip)
      ..writeByte(2)
      ..write(obj.countryName)
      ..writeByte(3)
      ..write(obj.countryCode)
      ..writeByte(4)
      ..write(obj.ping)
      ..writeByte(5)
      ..write(obj.speed)
      ..writeByte(6)
      ..write(obj.sessionNumber)
      ..writeByte(7)
      ..write(obj.openVpnConfigData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VpnAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
