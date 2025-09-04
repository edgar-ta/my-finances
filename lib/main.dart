import 'package:flutter/material.dart';
import 'package:my_finances/main_app.dart';
import 'package:my_finances/models/account.dart';
import 'package:my_finances/models/category.dart';
import 'package:my_finances/models/payment.dart';
import 'package:my_finances/models/recurrent_payment.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  return openDatabase(
    join(await getDatabasesPath(), "my_finances.db"),
    onCreate: (db, version) async {
      await Account.createTable(db);
      await Category.createTable(db);
      await RecurrentPayment.createTable(db);
      await Payment.createTable(db);
    },
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await getDatabase();
  runApp(const MainApp());
}
