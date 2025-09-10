import 'dart:io';

import 'package:my_finances/database/account_service.dart';
import 'package:my_finances/database/category_service.dart';
import 'package:my_finances/database/payment_service.dart';
import 'package:my_finances/database/recurrent_payment_service.dart';
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
        await AccountService().createTable(database);
        await CategoryService().createTable(database);
        await RecurrentPaymentService().createTable(database);
        await PaymentService().createTable(database);
      },
      version: 1,
    );
    return BriteDatabase(database);
  }
}
