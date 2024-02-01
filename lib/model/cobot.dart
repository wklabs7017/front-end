class Cobot {
  final String status;
  final String mode;

  Cobot({
    required this.status,
    required this.mode,
  });

  factory Cobot.fromJson(Map<String, dynamic> json) {
    return Cobot(
      status: json['status'] as String,
      mode: json['mode'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'mode': mode,
    };
  }
}
