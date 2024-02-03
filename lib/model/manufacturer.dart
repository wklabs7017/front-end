class Manufacturer {
  final int? id;
  final String name;
  final String contact;

  Manufacturer({this.id, required this.name, required this.contact});

  factory Manufacturer.fromJson(Map<String, dynamic> json) {
    return Manufacturer(
      id: json['id'],
      name: json['name'],
      contact: json['contact'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'contact': contact,
    };
  }
}
