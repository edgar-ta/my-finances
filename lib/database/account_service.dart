import 'package:my_finances/database/database_helper.dart';
import 'package:my_finances/database/database_service.dart';
import 'package:my_finances/main.dart';
import 'package:my_finances/models/account.dart';
import 'package:sqlbrite/sqlbrite.dart';

class AccountService implements DatabaseService<Account> {
  AccountService._();
  static final _instance = AccountService._();
  factory AccountService() {
    return _instance;
  }

  @override
  Future<void> deleteById(int id) {
    // TODO: implement deleteById
    throw UnimplementedError();
  }

  @override
  Stream<List<Account>> getAll() async* {
    final database = await DatabaseHelper.briteDatabase;
    yield* database
        .createQuery('Account')
        .mapToList((row) => Account.fromMap(row));
  }

  @override
  Stream<List<Account>> getById(int id) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateById(int id, Account value) {
    throw UnimplementedError();
  }

  @override
  Future<void> insert(Account value) async {
    (await DatabaseHelper.briteDatabase).insert('Account', value.toMap());
  }
}
