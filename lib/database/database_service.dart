import 'package:my_finances/database/database_helper.dart';
import 'package:my_finances/models/serializable.dart';
import 'package:sqlbrite/sqlbrite.dart';

mixin DatabaseService<K> {
  String get tableName;
  K entityFromMap(Map<String, dynamic> map);
  Map<String, dynamic> entityToMap(K entity);
  Future<void> createTable(Database database);

  Stream<List<K>> getAll() async* {
    final database = await DatabaseHelper.briteDatabase;
    yield* database
        .createQuery(tableName)
        .mapToList((map) => entityFromMap(map));
  }

  Future<int> deleteById(int id) async {
    return DatabaseHelper.briteDatabase.then((database) {
      return database.delete(tableName, where: 'id = ?', whereArgs: [id]);
    });
  }

  Stream<List<K>> getById(int id) async* {
    final database = await DatabaseHelper.briteDatabase;
    yield* database
        .createQuery(tableName, where: 'id = ?', whereArgs: [id])
        .mapToList((map) => entityFromMap(map));
  }

  Future<int> updateById(int id, K value) {
    return DatabaseHelper.briteDatabase.then((database) {
      return database.update(
        tableName,
        entityToMap(value),
        where: 'id = ?',
        whereArgs: [id],
      );
    });
  }

  Future<int> insert(K value) {
    return DatabaseHelper.briteDatabase.then((database) {
      return database.insert(tableName, entityToMap(value));
    });
  }
}
