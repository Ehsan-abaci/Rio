// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:uuid/uuid.dart';

import 'package:share_scooter/feature/home/presentation/screens/map_page.dart';

const uuid = Uuid();

class RideDetailEntity extends Equatable {
  String? rideId;
  Scooter scooter;
  DateTime startTime;
  DateTime? endTime;
  Duration? duration;
  double reservationCost;
  dynamic img;
  double? ridingCost;
  double? tax;
  double? totalCost;

  RideDetailEntity({
    this.rideId,
    required this.scooter,
    required this.startTime,
    this.endTime,
    this.duration,
    this.img,
    this.reservationCost = 1000,
    required this.ridingCost,
  }) {
    rideId = uuid.v4();
    tax = ridingCost != null ? (reservationCost + ridingCost!) * .1 : null;
    totalCost = ridingCost != null ? (reservationCost + ridingCost!) : null;
    duration = endTime?.difference(startTime);
  }

  List<Object?> get props => [
        scooter,
        startTime,
        endTime,
        duration,
        img,
        reservationCost,
        ridingCost,
        tax,
        totalCost,
      ];

  RideDetailEntity copyWith({
    String? rideId,
    Scooter? scooter,
    DateTime? startTime,
    DateTime? endTime,
    Duration? duration,
    dynamic img,
    double? reservationCost,
    double? ridingCost,
    double? tax,
    double? totalCost,
  }) {
    return RideDetailEntity(
      rideId: rideId ?? this.rideId,
      scooter: scooter ?? this.scooter,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      duration: duration ?? this.duration,
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
      'duration': duration?.toString(),
      'img': img,
      'reservationCost': reservationCost,
      'ridingCost': ridingCost,
      'tax': tax,
      'totalCost': totalCost,
    };
  }

  factory RideDetailEntity.fromMap(Map<String, dynamic> map) {
    return RideDetailEntity(
      rideId: map['rideId'] != null ? map['rideId'] as String : null,
      scooter: Scooter.fromJson(map['scooter'] as Map<String, dynamic>),
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime'] as int),
      endTime: map['endTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['endTime'] as int)
          : null,
      img: map['img'] as dynamic,
      reservationCost: map['reservationCost'] as double,
      ridingCost:
          map['ridingCost'] != null ? map['ridingCost'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RideDetailEntity.fromJson(String source) =>
      RideDetailEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
