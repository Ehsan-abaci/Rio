// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountModelAdapter extends TypeAdapter<AccountModel> {
  @override
  final int typeId = 2;

  @override
  AccountModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountModel(
      credit: fields[0] as double,
      card: fields[1] as CardDetailModel?,
      coupons: (fields[2] as List?)?.cast<CouponDetailModel>(),
      name: fields[3] as String,
      birthDate: fields[4] as DateTime?,
      phone: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AccountModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.credit)
      ..writeByte(1)
      ..write(obj.card)
      ..writeByte(2)
      ..write(obj.coupons)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.birthDate)
      ..writeByte(5)
      ..write(obj.phone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CardDetailModelAdapter extends TypeAdapter<CardDetailModel> {
  @override
  final int typeId = 3;

  @override
  CardDetailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardDetailModel(
      cardName: fields[0] as String,
      cardNumber: fields[1] as String,
      cardMonthDate: fields[2] as String,
      cardYearDate: fields[3] as String,
      cardCvv2: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CardDetailModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.cardName)
      ..writeByte(1)
      ..write(obj.cardNumber)
      ..writeByte(2)
      ..write(obj.cardMonthDate)
      ..writeByte(3)
      ..write(obj.cardYearDate)
      ..writeByte(4)
      ..write(obj.cardCvv2);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardDetailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CouponDetailModelAdapter extends TypeAdapter<CouponDetailModel> {
  @override
  final int typeId = 4;

  @override
  CouponDetailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CouponDetailModel(
      couponName: fields[0] as String,
      credit: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CouponDetailModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.couponName)
      ..writeByte(1)
      ..write(obj.credit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CouponDetailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
