// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamics_news/domain/models/location.dart';
import 'package:dynamics_news/domain/repositorires/database.dart';

class FirestoreDatabase extends DatabaseInterface {
  // We get the Firestore instance
  final _firestore = FirebaseFirestore.instance;

  FirebaseFirestore get databaseInstance => _firestore;

  // With the documents collection ref we add a new document,
  // the reference will be set automatically
  @override
  Future<void> add(
      {required String collectionPath,
      required Map<String, dynamic> data}) async {
    await _firestore.collection(collectionPath).add(data);
  }

  // With the document reference we can add/replace it with
  // the data provided
  @override
  Future<void> addWithReference(
      {required String documentPath,
      required Map<String, dynamic> data}) async {
    await _firestore.doc(documentPath).set(data);
  }

  // We use the document reference to delete it
  @override
  Future<void> deleteDoc({required String documentPath}) async {
    await _firestore.doc(documentPath).delete();
  }

  // We read the document specified by the document reference
  @override
  Future<Map<String, dynamic>?> readDoc({required String documentPath}) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.doc(documentPath).get();
    return snapshot.data();
  }

  // We get all the documents inside the collection
  // specified by te collection reference
  @override
  Future<List<Map<String, dynamic>>> readCollection(
      {required String collectionPath}) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection(collectionPath).get();
    List<Map<String, dynamic>> docs = [];
    // Since we fetch all the documents within the collection,
    // we also need to save the references of each of the documents,
    // so that, if necessary, we can apply actions on them in firestore later.
    for (var document in snapshot.docs) {
      docs.add({
        "ref": document.reference,
        "data": document.data(),
      });
    }
    return docs;
  }

  // We update the specified fields in the document
  // specified by the document reference
  @override
  Future<void> updateDoc(
      {required String documentPath,
      required Map<String, dynamic> data}) async {
    await _firestore.doc(documentPath).update(data);
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> listenCollection(
      {required String collectionPath}) {
    // Since we are going to fetch users interaction data,
    // we can establish a fetch window, 24 hours in this case.

    // IMPORTANT! This query is case specific.

    // H * m * s * ms
    const lifeSpan = 24 * 60 * 60 * 1000;
    final minimumTimestamp = Timestamp.fromMillisecondsSinceEpoch(
        Timestamp.now().millisecondsSinceEpoch - lifeSpan);

    return FirebaseFirestore.instance
        .collection(collectionPath)
        //.where('timestamp', isGreaterThanOrEqualTo: minimumTimestamp)
        .orderBy('timestamp', descending: true)
        .limit(15)
        .snapshots();
  }

  List<Map<String, dynamic>> extractDocs(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<Map<String, dynamic>> docs = [];
    // Since we fetch all the documents within the collection,
    // we also need to save the references of each of the documents,
    // so that, if necessary, we can apply actions on them in firestore later.
    for (var document in snapshot.docs) {
      docs.add({
        "ref": document.reference.path,
        "data": document.data(),
      });
    }
    return docs;
  }

  Future<void> guardarubicacion(Map<String, dynamic> ubicacion, uid) async {
    print("entro guardarubicacion");
    print("ubicacion: " + ubicacion.toString());
    print("id: " + uid);
    await _firestore.collection('ubicacion').doc(uid).set(ubicacion).catchError((e) {
      print(e);
    });
    print("salio guardarubicacion");
    //return true;
  }

  Stream<QuerySnapshot> readLocations() {
    CollectionReference listado = _firestore.collection('ubicacion');

    return listado.snapshots();
  }


}
