import 'package:cloud_firestore/cloud_firestore.dart';

class UserStatus {
  String picUrl, name, email, message;
  String? dbRef;

  UserStatus({
    required this.picUrl,
    required this.name,
    required this.email,
    required this.message,
    this.dbRef,
  });

  factory UserStatus.fromJson(Map<String, dynamic> map) {
    final data = map["data"];
    return UserStatus(
        //picUrl: data['picUrl']==null?'':data['picUrl'],
        picUrl: data['picUrl']??'',
        name: data['name'],
        email: data['email'],
        message: data['message'],
        dbRef: map['ref']);
  }

  Map<String, dynamic> toJson() {
    return {
      "picUrl": picUrl,
      "name": name,
      "email": email,
      "message": message,
      "timestamp": Timestamp.now(),
    };
  }
}
