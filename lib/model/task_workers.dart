class TaskWorkers {
  final int workerId;
  final String workerDisplayId;
  final String name;
  final String email;
  final String tenant;
  final String privilege;

  TaskWorkers({
    required this.workerId,
    required this.workerDisplayId,
    required this.name,
    required this.email,
    required this.tenant,
    required this.privilege,
  });

  factory TaskWorkers.fromJson(Map<String, dynamic> json) {
    return TaskWorkers(
      workerId: json['worker_id'] as int,
      workerDisplayId: json['worker_display_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      tenant: json['tenant'] as String,
      privilege: json['privilege'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'worker_id': workerId,
      'worker_display_id': workerDisplayId,
      'name': name,
      'email': email,
      'tenant': tenant,
      'privilege': privilege,
    };
  }
}
