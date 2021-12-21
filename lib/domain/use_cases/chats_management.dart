// ignore_for_file: avoid_print, prefer_is_not_empty

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamics_news/data/repositories/firestore_database.dart';
import 'package:dynamics_news/domain/models/user_chat.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;


class ChatsManager {
  final _database = FirestoreDatabase();

  Future<dynamic> cargarfoto(var foto, var idfoto) async {
    final fs.Reference storageReference =
        fs.FirebaseStorage.instance.ref().child("ChatsDir");

    fs.TaskSnapshot taskSnapshot =
        await storageReference.child(idfoto).putFile(foto);

    var url = await taskSnapshot.ref.getDownloadURL();
    print('url:' + url.toString());
    return url.toString();
  }  

  Future<void> sendChat(UserChat job, foto) async {
    print("entro sendChat");
/*
    var url = '';
    if (foto != null) {
      print("sendChat entro a cargarfoto");
      url = await cargarfoto(foto, DateTime.now().toString());
      job.picUrl = url.toString();
    }
    print("url: " + url);
*/
    await _database.add(collectionPath: "chatsUsers", data: job.toJson());
  }

  Future<void> updateChat(UserChat job, foto) async {
    print("entro updateChat");
/*    
    var url = '';
    if (foto != null) {
      print("updateChat entro a cargarfoto");
      url = await cargarfoto(foto, DateTime.now().toString());
      job.picUrl = url.toString();
    }
    print("url: " + url);
*/
    await _database.updateDoc(documentPath: job.dbRef!, data: job.toJson());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getJobsStream() {
    return _database.listenCollection(collectionPath: "chatsUsers");
  }

  Future<List<UserChat>> getJobsOnce() async {
    final chatsData =
        await _database.readCollection(collectionPath: "chatsUsers");
    return _extractInstances(chatsData);
  }

  List<UserChat> extractChats(QuerySnapshot<Map<String, dynamic>> snapshot) {
    final chatsData = _database.extractDocs(snapshot);
    print("chatsData.length: " + chatsData.length.toString());
    return _extractInstances(chatsData);
  }

  Future<void> removeChat(UserChat chat) async {
    await _database.deleteDoc(documentPath: chat.dbRef!);
  }

  List<UserChat> _extractInstances(List<Map<String, dynamic>> data) {
    List<UserChat> chats = [];
    for (var statusJson in data) {
      chats.add(UserChat.fromJson(statusJson));
    }
    return chats;
  }
}
