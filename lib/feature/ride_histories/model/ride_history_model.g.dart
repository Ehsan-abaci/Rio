// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_history_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RideHistoryModelAdapter extends TypeAdapter<RideHistoryModel> {
  @override
  final int typeId = 0;

  @override
  RideHistoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RideHistoryModel(
      rideId: fields[0] as String?,
      scooter: fields[1] as Scooter,
      startTime: fields[2] as DateTime,
      endTime: fields[3] as DateTime?,
      durationInMilliSeconds: fields[4] as int?,
      img: fields[6] as String?,
      reservationCost: fields[5] as double,
      ridingCost: fields[7] as double?,
    )
      ..tax = fields[8] as double?
      ..totalCost = fields[9] as double?;
  }

  @override
  void write(BinaryWriter writer, RideHistoryModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.rideId)
      ..writeByte(1)
      ..write(obj.scooter)
      ..writeByte(2)
      ..write(obj.startTime)
      ..writeByte(3)
      ..write(obj.endTime)
      ..writeByte(4)
      ..write(obj.durationInMilliSeconds)
      ..writeByte(5)
      ..write(obj.reservationCost)
      ..writeByte(6)
      ..write(obj.img)
      ..writeByte(7)
      ..write(obj.ridingCost)
      ..writeByte(8)
      ..write(obj.tax)
      ..writeByte(9)
      ..write(obj.totalCost);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RideHistoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
