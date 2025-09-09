import 'package:flutter/material.dart';
import 'package:my_finances/main_app.dart';
import 'package:my_finances/models/account.dart';
import 'package:my_finances/models/category.dart';
import 'package:my_finances/models/payment.dart';
import 'package:my_finances/models/recurrent_payment.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqlbrite/sqlbrite.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  databaseFactory = databaseFactoryFfi;

  runApp(const MainApp());
}
