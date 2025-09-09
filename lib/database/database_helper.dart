import 'dart:io';

import 'package:my_finances/models/account.dart';
import 'package:my_finances/models/category.dart';
import 'package:my_finances/models/payment.dart';
import 'package:my_finances/models/recurrent_payment.dart';
import 'package:sqlbrite/sqlbrite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static BriteDatabase? _briteDatabase;

  static Future<BriteDatabase> get briteDatabase async {
    if (_briteDatabase != null) return _briteDatabase!;
    _briteDatabase = await _initBriteDatabase();
    return _briteDatabase!;
  }

  static Future<BriteDatabase> _initBriteDatabase() async {
    final database = await openDatabase(
      join(await getDatabasesPath(), "my_finances.db"),
      onCreate: (database, version) async {
        await Account.createTable(database);
        await Category.createTable(database);
        await RecurrentPayment.createTable(database);
        await Payment.createTable(database);
      },
      version: 1,
    );
    return BriteDatabase(database);
  }
}
