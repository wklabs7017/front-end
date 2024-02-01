class User {
  final int id;
  String userId;
  String email;
  String name;
  int tenant;
  String privilege;

  User({
    required this.name,
    required this.id,
    required this.userId,
    required this.email,
    required this.tenant,
    required this.privilege,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    print(json['id']);
    print(json['id'].runtimeType);
    return User(
      id: json['id'] as int,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      tenant: json['tenant'] as int,
      privilege: json['privilege'] as String,
    );
  }
}
