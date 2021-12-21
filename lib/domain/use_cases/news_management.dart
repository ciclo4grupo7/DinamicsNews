// ignore_for_file: avoid_print, prefer_is_not_empty

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamics_news/data/repositories/firestore_database.dart';
import 'package:dynamics_news/domain/models/user_anew.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;


class NewsManager {
  final _database = FirestoreDatabase();

  Future<dynamic> cargarfoto(var foto, var idfoto) async {
    final fs.Reference storageReference =
        fs.FirebaseStorage.instance.ref().child("Estados");

    fs.TaskSnapshot taskSnapshot =
        await storageReference.child(idfoto).putFile(foto);

    var url = await taskSnapshot.ref.getDownloadURL();
    print('url:' + url.toString());
    return url.toString();
  }  

  Future<void> sendANews(UserANew job, foto) async {
    print("entro sendANews");
    var url = '';
    if (foto != null) {
      print("sendANews entro a cargarfoto");
      url = await cargarfoto(foto, DateTime.now().toString());
      job.picUrl = url.toString();
    }
    print("url: " + url);

    await _database.add(collectionPath: "newsUsers", data: job.toJson());
  }

  Future<void> updateANews(UserANew job, foto) async {
    print("entro updateANews");
    var url = '';
    if (foto != null) {
      print("updateANews entro a cargarfoto");
      url = await cargarfoto(foto, DateTime.now().toString());
      job.picUrl = url.toString();
    }
    print("url: " + url);

    await _database.updateDoc(documentPath: job.dbRef!, data: job.toJson());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getJobsStream() {
    return _database.listenCollection(collectionPath: "newsUsers");
  }

  Future<List<UserANew>> getJobsOnce() async {
    final offersData =
        await _database.readCollection(collectionPath: "newsUsers");
    return _extractInstances(offersData);
  }

  List<UserANew> extractNews(QuerySnapshot<Map<String, dynamic>> snapshot) {
    final offersData = _database.extractDocs(snapshot);
    print("offersData.length: " + offersData.length.toString());
    return _extractInstances(offersData);
  }

  Future<void> removeANews(UserANew offer) async {
    await _database.deleteDoc(documentPath: offer.dbRef!);
  }

  List<UserANew> _extractInstances(List<Map<String, dynamic>> data) {
    List<UserANew> offers = [];
    for (var statusJson in data) {
      offers.add(UserANew.fromJson(statusJson));
    }
    return offers;
  }
}
