// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scooter_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScooterAdapter extends TypeAdapter<Scooter> {
  @override
  final int typeId = 1;

  @override
  Scooter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Scooter(
      id: fields[0] as String,
      name: fields[1] as String,
      lat: fields[2] as double,
      lng: fields[3] as double,
      batteryLevel: fields[4] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Scooter obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.lat)
      ..writeByte(3)
      ..write(obj.lng)
      ..writeByte(4)
      ..write(obj.batteryLevel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScooterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
