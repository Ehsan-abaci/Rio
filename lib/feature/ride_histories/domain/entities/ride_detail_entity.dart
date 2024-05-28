import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:share_scooter/feature/home/presentation/screens/home_page.dart';
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
  Duration? duration;
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
    this.duration,
    this.img,
    this.reservationCost = 1000,
    required this.ridingCost,
  }) {
    rideId = rideId ?? uuid.v4();
    tax = (reservationCost + (ridingCost ?? 0)) * .1;
    totalCost = (reservationCost + (ridingCost ?? 0));
    duration = duration ?? endTime?.difference(startTime);
  }

  @override
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
      duration: duration ?? this.duration,
      img: img ?? this.img,
      reservationCost: reservationCost ?? this.reservationCost,
      ridingCost: ridingCost ?? this.ridingCost,
    );
  }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'rideId': rideId,
  //     'scooter': scooter.tojson(),
  //     'startTime': startTime.millisecondsSinceEpoch,
  //     'endTime': endTime?.millisecondsSinceEpoch,
  //     'duration': duration?.toString(),
  //     'img': img,
  //     'reservationCost': reservationCost,
  //     'ridingCost': ridingCost,
  //     'tax': tax,
  //     'totalCost': totalCost,
  //   };
  // }

  // factory RideDetailEntity.fromMap(Map<String, dynamic> map) {
  //   return RideDetailEntity(
  //     rideId: map['rideId'] != null ? map['rideId'] as String : null,
  //     scooter: Scooter.fromJson(map['scooter'] as Map<String, dynamic>),
  //     startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime'] as int),
  //     endTime: map['endTime'] != null
  //         ? DateTime.fromMillisecondsSinceEpoch(map['endTime'] as int)
  //         : null,
  //     img: map['img'] != null ? map['img'] as String : null,
  //     reservationCost: map['reservationCost'] as double,
  //     ridingCost:
  //         map['ridingCost'] != null ? map['ridingCost'] as double : null,
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory RideDetailEntity.fromJson(String source) =>
  //     RideDetailEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
