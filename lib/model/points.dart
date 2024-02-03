class Point {
  double latitude;
  double longitude;

  Point({
    required this.latitude,
    required this.longitude,
  });

  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
