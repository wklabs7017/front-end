import 'package:bsn_v2/model/area.dart';
import 'package:bsn_v2/model/points.dart';

class Tenant {
  int id;
  Point point;
  String name;
  DateTime createdAt;
  DateTime? deletedAt;
  List<int> devices;
  List<int> workers;

  Tenant({
    required this.id,
    required this.point,
    required this.name,
    required this.createdAt,
    this.deletedAt,
    required this.devices,
    required this.workers,
  });

  factory Tenant.fromJson(Map<String, dynamic> json) {
    return Tenant(
      id: json['id'] as int,
      point: Point.fromJson(json['point'] as Map<String, dynamic>),
      name: json['name'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'] as String)
          : null,
      devices: List<int>.from(json['devices'] as List),
      workers: List<int>.from(json['workers'] as List),
    );
  }
}
