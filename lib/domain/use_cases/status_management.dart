import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamics_news/data/repositories/firestore_database.dart';
import 'package:dynamics_news/domain/models/user_status.dart';

class StatusManager {
  final _database = FirestoreDatabase();

  Future<void> sendStatus(UserStatus status) async {
    await _database.add(collectionPath: "statuses", data: status.toJson());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getStatusesStream() {
    return _database.listenCollection(collectionPath: "statuses");
  }

  Future<List<UserStatus>> getStatusesOnce() async {
    final statusesData =
        await _database.readCollection(collectionPath: "statuses");
    return _extractInstances(statusesData);
  }

  List<UserStatus> extractStatuses(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    final statusesData = _database.extractDocs(snapshot);
    return _extractInstances(statusesData);
  }

  Future<void> removeStatus(UserStatus status) async {
    await _database.deleteDoc(documentPath: status.dbRef!);
  }

  List<UserStatus> _extractInstances(List<Map<String, dynamic>> data) {
    List<UserStatus> statuses = [];
    for (var statusJson in data) {
      statuses.add(UserStatus.fromJson(statusJson));
    }
    return statuses;
  }
}
