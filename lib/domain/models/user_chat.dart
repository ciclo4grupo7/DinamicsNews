import 'package:cloud_firestore/cloud_firestore.dart';

class UserChat {
  String picUrl, name, email, message, title;
  String? dbRef;

  UserChat({
    required this.picUrl,
    required this.name,
    required this.email,
    required this.message,
    required this.title,
    this.dbRef,
  });

  factory UserChat.fromJson(Map<String, dynamic> map) {
    final data = map["data"];
    return UserChat(
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
