class UserProfile {
  String name;
  String email;
  String phone;
   String imagePath;

  UserProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'imagePath': imagePath,
      
    };
  }

  factory UserProfile.fromMap(
    Map<String, dynamic> map,
  ) {
    return UserProfile(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
       imagePath: map['imagePath'] ?? '',
    );
  }
}