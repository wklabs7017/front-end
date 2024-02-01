class WorkLog {
  final int userId;
  final DateTime createdAt;
  final DateTime startedAt;
  final DateTime endedAt;
  final String message;

  WorkLog({
    required this.userId,
    required this.createdAt,
    required this.startedAt,
    required this.endedAt,
    required this.message,
  });

  // JSON에서 WorkLog 객체로 변환하는 팩토리 생성자
  factory WorkLog.fromJson(Map<String, dynamic> json) {
    return WorkLog(
      userId: json['user_id'] as int,
      createdAt: DateTime.parse(json['created_at']),
      startedAt: DateTime.parse(json['started_at']),
      endedAt: DateTime.parse(json['ended_at']),
      message: json['message'] as String,
    );
  }

  // WorkLog 객체를 JSON으로 변환하는 메소드
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
      'started_at': startedAt.toIso8601String(),
      'ended_at': endedAt.toIso8601String(),
      'message': message,
    };
  }
}
