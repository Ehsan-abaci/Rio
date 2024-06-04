// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:latlong2/latlong.dart';

part 'scooter_entity.g.dart';

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

  Scooter({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
  });


  Map<String, dynamic> tojson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'lat': lat,
      'lng': lng,
    };
  }

  factory Scooter.fromJson(Map<String, dynamic> map) {
    return Scooter(
      id: map['id'] as String,
      name: map['name'] as String,
      lat: map['lat'] as double,
      lng: map['lng'] as double,
    );
  }

}
