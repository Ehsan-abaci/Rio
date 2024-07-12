// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'scooter_model.g.dart';

@HiveType(typeId: 1)
class Scooter {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  double lat;
  @HiveField(3)
  double lng;
  @HiveField(4)
  double batteryLevel;

  Scooter({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    this.batteryLevel = 100.0,
  });

  Map<String, dynamic> tojson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'lat': lat,
      'lng': lng,
      'batteryLevel': batteryLevel,
    };
  }

  factory Scooter.fromJson(Map<String, dynamic> map) {
    return Scooter(
      id: map['id'] as String,
      name: map['name'] as String,
      lat: map['lat'] as double,
      lng: map['lng'] as double,
      batteryLevel: map['batteryLevel'] as double,
    );
  }

  Scooter copyWith({
    String? id,
    String? name,
    double? lat,
    double? lng,
    double? batteryLevel,
  }) {
    return Scooter(
      id: id ?? this.id,
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      batteryLevel: batteryLevel ?? this.batteryLevel,
    );
  }
}
