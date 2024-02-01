class Task {
  final int id;
  final DateTime createdAt;
  final DateTime startedAt;
  final DateTime endedAt;
  final String name;
  final String description;
  final String status;
  final String type;

  Task({
    required this.id,
    required this.createdAt,
    required this.startedAt,
    required this.endedAt,
    required this.name,
    required this.description,
    required this.status,
    required this.type,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['created_at']),
      startedAt: DateTime.parse(json['started_at']),
      endedAt: DateTime.parse(json['ended_at']),
      name: json['name'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'started_at': startedAt.toIso8601String(),
      'ended_at': endedAt.toIso8601String(),
      'name': name,
      'description': description,
      'status': status,
      'type': type,
    };
  }
}
