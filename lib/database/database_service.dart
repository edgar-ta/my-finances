abstract class DatabaseService<K> {
  DatabaseService._();

  Stream<List<K>> getAll();
  Future<void> deleteById(int id);
  Stream<List<K>> getById(int id);
  Future<void> updateById(int id, K value);
  Future<void> insert(K value);
}
