class SmartRack {
  final int id;
  final int number;
  final DateTime createdAt;
  final bool ledOn;
  final String ledMode;
  final DateTime lastWorkedAt;

  SmartRack({
    required this.id,
    required this.number,
    required this.createdAt,
    required this.ledOn,
    required this.ledMode,
    required this.lastWorkedAt,
  });

  // JSON에서 SmartRack 객체로 변환하는 팩토리 생성자
  factory SmartRack.fromJson(Map<String, dynamic> json) {
    return SmartRack(
      id: json['id'] as int,
      number: json['number'] as int,
      createdAt: DateTime.parse(json['created_at']),
      ledOn: json['led_on'] as bool,
      ledMode: json['led_mode'] as String,
      lastWorkedAt: DateTime.parse(json['last_worked_at']),
    );
  }

  // SmartR

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': number,
      'created_at': createdAt.toIso8601String(),
      'led_on': ledOn,
      'led_mode': ledMode,
      'last_worked_at': lastWorkedAt.toIso8601String(),
    };
  }
}
