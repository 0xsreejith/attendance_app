class UserModel {
  final String uid;
  final String name;
  final String email;
  final String mobile;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.mobile,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      mobile: map['mobile'] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'name': name,
        'email': email,
        'mobile': mobile,
      };
}
