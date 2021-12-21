class ANewUser {
  String name, pictureUrl, email;

  ANewUser({
    required this.name,
    required this.email,
    required this.pictureUrl,
  });

  factory ANewUser.fromJson(Map<String, dynamic> map) {
    return ANewUser(
      name: map['name'],
      email: map['email'],
      pictureUrl: map['pictureUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "pictureUrl": pictureUrl,
    };
  }
}
