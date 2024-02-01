import 'package:bsn_v2/model/points.dart';

class Area {
  List<Point> points;

  Area({required this.points});

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        points: List<Point>.from(json['points'].map((x) => Point.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'points': List<dynamic>.from(points.map((x) => x.toJson())),
      };
}
