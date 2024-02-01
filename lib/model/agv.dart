class AGV {
  final String status;
  final String mode;
  final int batteryLevel;
  final int driveDistance;

  AGV({
    required this.status,
    required this.mode,
    required this.batteryLevel,
    required this.driveDistance,
  });

  factory AGV.fromJson(Map<String, dynamic> json) {
    return AGV(
      status: json['status'] as String,
      mode: json['mode'] as String,
      batteryLevel: json['battery_level'] as int,
      driveDistance: json['drive_distance'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'mode': mode,
      'battery_level': batteryLevel,
      'drive_distance': driveDistance,
    };
  }
}
