import 'dart:convert';

import 'package:share_scooter/feature/ride_histories/domain/entities/ride_detail_entity.dart';
import 'package:share_scooter/feature/ride_histories/domain/entities/scooter_entity.dart';

class RideDetailModel extends RideDetailEntity {
  RideDetailModel({
    required super.scooter,
    required super.startTime,
    required super.ridingCost,
    super.endTime,
    super.durationInMilliSeconds,
    super.img,
    super.reservationCost,
    super.rideId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rideId': rideId,
      'scooter': scooter.tojson(),
      'startTime': startTime.millisecondsSinceEpoch,
      'endTime': endTime?.millisecondsSinceEpoch,
      'durationInMilliSeconds': durationInMilliSeconds?.toString(),
      'img': img,
      'reservationCost': reservationCost,
      'ridingCost': ridingCost,
      'tax': tax,
      'totalCost': totalCost,
    };
  }

  factory RideDetailModel.fromMap(Map<String, dynamic> map) {
    return RideDetailModel(
      rideId: map['rideId'] != null ? map['rideId'] as String : null,
      scooter: Scooter.fromJson(map['scooter'] as Map<String, dynamic>),
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime'] as int),
      endTime: map['endTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['endTime'] as int)
          : null,
      img: map['img'] != null ? map['img'] as String : null,
      reservationCost: map['reservationCost'] as double,
      ridingCost:
          map['ridingCost'] != null ? map['ridingCost'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RideDetailModel.fromJson(String source) =>
      RideDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
