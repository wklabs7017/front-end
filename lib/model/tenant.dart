import 'package:bsn_v2/model/area.dart';

class Tenant {
  int id;
  Area area;
  String name;
  String createdAt;
  String deletedAt;
  List<int> devices;
  List<int> workers;

  Tenant({
    required this.id,
    required this.area,
    required this.name,
    required this.createdAt,
    required this.deletedAt,
    required this.devices,
    required this.workers,
  });

  factory Tenant.fromJson(Map<String, dynamic> json) => Tenant(
        id: json['id'],
        area: Area.fromJson(json['area']),
        name: json['name'],
        createdAt: json['created_at'] ?? '213232',
        deletedAt: json['deleted_at'] ?? 'sdasdsadsad',
        devices: List<int>.from(json['devices'].map((x) => x)) ?? [],
        workers: List<int>.from(json['workers'].map((x) => x)) ?? [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'area': area.toJson(),
        'name': name,
        'created_at': createdAt,
        'deleted_at': deletedAt,
        'devices': List<dynamic>.from(devices.map((x) => x)),
        'workers': List<dynamic>.from(workers.map((x) => x)),
      };
}
