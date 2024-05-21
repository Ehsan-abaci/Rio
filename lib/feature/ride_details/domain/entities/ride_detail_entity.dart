// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:share_scooter/feature/home/presentation/screens/map_page.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class RideDetailEntity extends Equatable {
  String? rideId;
  Scooter scooter;
  DateTime startTime;
  DateTime? endTime;
  Duration? duration;
  double reservationCost;
  double? ridingCost;
  double? tax;
  double? totalCost;

  RideDetailEntity({
    this.rideId,
    required this.scooter,
    required this.startTime,
     this.endTime,
     this.duration,
    this.reservationCost = 1000,
     this.ridingCost,
  }) {
    rideId = uuid.v4();
    tax = ridingCost != null ? (reservationCost + ridingCost!) * .1 : null;
    totalCost =
        ridingCost != null ? (reservationCost + ridingCost! + tax!) : null;
  }

  List<Object?> get props => [
        scooter,
        startTime,
        endTime,
        duration,
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
      reservationCost: reservationCost ?? this.reservationCost,
      ridingCost: ridingCost ?? this.ridingCost,
    );
  }
}
