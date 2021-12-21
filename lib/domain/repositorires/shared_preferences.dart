abstract class SharedPreferencesInterface {
  Future<void> storeData<T>(String key, T value);

  Future<T?> retrieveData<T>(String key);
}
