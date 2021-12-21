import 'package:cloud_firestore/cloud_firestore.dart';

class UserANew {
  String picUrl, name, email, message, title;
  String? dbRef;

  UserANew({
    required this.picUrl,
    required this.name,
    required this.email,
    required this.message,
    required this.title,
    this.dbRef,
  });

  factory UserANew.fromJson(Map<String, dynamic> map) {
    final data = map["data"];
    return UserANew(
        picUrl: data['picUrl'],
        name: data['name'],
        email: data['email'],
        message: data['message'],
        title: data['title'],
        dbRef: map['ref']);
  }

  Map<String, dynamic> toJson() {
    return {
      "picUrl": picUrl,
      "name": name,
      "email": email,
      "message": message,
      "title": title,
      "timestamp": Timestamp.now(),
    };
  }
}
