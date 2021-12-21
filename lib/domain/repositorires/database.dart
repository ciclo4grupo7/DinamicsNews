abstract class DatabaseInterface {
  // CRUD operations

  Future<void> add(
      {required String collectionPath, required Map<String, dynamic> data});

  Future<void> addWithReference(
      {required String documentPath, required Map<String, dynamic> data});

  Future<void> readDoc({required String documentPath});

  Future readCollection(
      {required String collectionPath});

  Stream listenCollection({required String collectionPath});

  Future<void> updateDoc(
      {required String documentPath, required Map<String, dynamic> data});

  Future<void> deleteDoc({required String documentPath});
}
