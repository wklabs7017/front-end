class ConsoleLog {
  List<String> levels;
  String to;
  String from;
  List<int> userIds;

  ConsoleLog({
    required this.levels,
    required this.to,
    required this.from,
    required this.userIds,
  });

  // JSON에서 이 클래스의 인스턴스를 생성하기 위한 팩토리 생성자
  factory ConsoleLog.fromJson(Map<String, dynamic> json) {
    return ConsoleLog(
      levels: List<String>.from(json['levels']),
      to: json['to'],
      from: json['from'],
      userIds: List<int>.from(json['user_id']),
    );
  }

  // 이 클래스의 인스턴스를 JSON으로 변환하기 위한 메서드
  Map<String, dynamic> toJson() {
    return {
      'levels': levels,
      'to': to,
      'from': from,
      'user_id': userIds,
    };
  }
}
