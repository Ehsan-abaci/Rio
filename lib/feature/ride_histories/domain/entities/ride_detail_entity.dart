import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:share_scooter/feature/ride_histories/domain/entities/scooter_entity.dart';
import 'package:uuid/uuid.dart';
part 'ride_detail_entity.g.dart';

const uuid = Uuid();

@HiveType(typeId: 0)
class RideDetailEntity extends Equatable {
  @HiveField(0)
  String? rideId;
  @HiveField(1)
  Scooter scooter;
  @HiveField(2)
  DateTime startTime;
  @HiveField(3)
  DateTime? endTime;
  @HiveField(4)
  int? durationInMilliSeconds;
  @HiveField(5)
  double reservationCost;
  @HiveField(6)
  String? img;
  @HiveField(7)
  double? ridingCost;
  @HiveField(8)
  double? tax;
  @HiveField(9)
  double? totalCost;

  RideDetailEntity({
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

  RideDetailEntity copyWith({
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
    return RideDetailEntity(
      rideId: rideId ?? this.rideId,
      scooter: scooter ?? this.scooter,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      durationInMilliSeconds: durationInMilliSeconds ?? this.durationInMilliSeconds,
      img: img ?? this.img,
      reservationCost: reservationCost ?? this.reservationCost,
      ridingCost: ridingCost ?? this.ridingCost,
    );
  }
}
