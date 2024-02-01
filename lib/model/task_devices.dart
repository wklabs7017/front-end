class TaskDevices {
  final int deviceId;
  final String name;
  final String modelName;
  final String type;
  final String status;
  final DateTime equippedAt;
  final int tenantId;
  final String manufacturerName;
  final String manufacturerContact;

  TaskDevices({
    required this.deviceId,
    required this.name,
    required this.modelName,
    required this.type,
    required this.status,
    required this.equippedAt,
    required this.tenantId,
    required this.manufacturerName,
    required this.manufacturerContact,
  });

  factory TaskDevices.fromJson(Map<String, dynamic> json) {
    return TaskDevices(
      deviceId: json['device_id'] as int,
      name: json['name'] as String,
      modelName: json['model_name'] as String,
      type: json['type'] as String,
      status: json['status'] as String,
      equippedAt: DateTime.parse(json['equipped_at']),
      tenantId: json['tenant_id'] as int,
      manufacturerName: json['manufacturer_name'] as String,
      manufacturerContact: json['manufacturer_contact'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'device_id': deviceId,
      'name': name,
      'model_name': modelName,
      'type': type,
      'status': status,
      'equipped_at': equippedAt.toIso8601String(),
      'tenant_id': tenantId,
      'manufacturer_name': manufacturerName,
      'manufacturer_contact': manufacturerContact,
    };
  }
}
