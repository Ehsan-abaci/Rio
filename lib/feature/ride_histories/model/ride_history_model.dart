// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:share_scooter/feature/ride_histories/model/scooter_model.dart';
import 'package:uuid/uuid.dart';
part 'ride_history_model.g.dart';

const uuid = Uuid();

@HiveType(typeId: 0)
class RideHistoryModel extends Equatable {
  @HiveField(0)
  String? rideId;
  @HiveField(1)
  final Scooter scooter;
  @HiveField(2)
  final DateTime startTime;
  @HiveField(3)
  final DateTime? endTime;
  @HiveField(4)
  int? durationInMilliSeconds;
  @HiveField(5)
  final double reservationCost;
  @HiveField(6)
  String? img;
  @HiveField(7)
  double? ridingCost;
  @HiveField(8)
  double? tax;
  @HiveField(9)
  double? totalCost;

  RideHistoryModel({
    this.rideId,
    required this.scooter,
    required this.startTime,
    this.endTime,
    this.durationInMilliSeconds,
    this.img,
    this.reservationCost = 1000,
    required this.ridingCost,
  }) {
    rideId = rideId ?? uuid.v4();
    totalCost = (reservationCost + (ridingCost ?? 0));
    tax = totalCost! * .1;
    durationInMilliSeconds =
        durationInMilliSeconds ?? endTime?.difference(startTime).inMilliseconds;
  }

  @override
  List<Object?> get props => [
        scooter,
        startTime,
        endTime,
        durationInMilliSeconds,
        img,
        reservationCost,
        ridingCost,
        tax,
        totalCost,
      ];



  RideHistoryModel copyWith({
    String? rideId,
    Scooter? scooter,
    DateTime? startTime,
    DateTime? endTime,
    int? durationInMilliSeconds,
    String? img,
    double? reservationCost,
    double? ridingCost,
    double? tax,
    double? totalCost,
  }) {
    return RideHistoryModel(
      rideId: rideId ?? this.rideId,
      scooter: scooter ?? this.scooter,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      durationInMilliSeconds:
          durationInMilliSeconds ?? this.durationInMilliSeconds,
      img: img ?? this.img,
      reservationCost: reservationCost ?? this.reservationCost,
      ridingCost: ridingCost ?? this.ridingCost,
    );
  }

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

  factory RideHistoryModel.fromMap(Map<String, dynamic> map) {
    return RideHistoryModel(
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

  factory RideHistoryModel.fromJson(String source) =>
      RideHistoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}


