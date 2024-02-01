class Conveyor {
  final String status;
  final int speed;

  Conveyor({
    required this.status,
    required this.speed,
  });

  factory Conveyor.fromJson(Map<String, dynamic> json) {
    return Conveyor(
      status: json['status'] as String,
      speed: json['speed'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'speed': speed,
    };
  }
}
