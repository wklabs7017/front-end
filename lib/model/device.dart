class Device {
  final int id;
  String name;
  final String modelName;
  final String type;
  final DateTime equippedAt;
  final int tenantId;
  final String manufacturerName;
  final String manufacturerContact;

  Device({
    required this.id,
    required this.name,
    required this.modelName,
    required this.type,
    required this.equippedAt,
    required this.tenantId,
    required this.manufacturerName,
    required this.manufacturerContact,
  });

  // JSON에서 Equipment 객체로 변환하는 팩토리 생성자
  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'],
      name: json['name'],
      modelName: json['model_name'],
      type: json['type'],
      equippedAt: DateTime.parse(json['equipped_at']),
      tenantId: json['tenant_id'],
      manufacturerName: json['manufacturer_name'],
      manufacturerContact: json['manufacturer_contact'],
    );
  }

  // Equipment 객체를 JSON으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'model_name': modelName,
      'type': type,
      'equipped_at': equippedAt.toIso8601String(),
      'tenant_id': tenantId,
      'manufacturer_name': manufacturerName,
      'manufacturer_contact': manufacturerContact,
    };
  }
}
