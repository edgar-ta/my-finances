import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_finances/control_variables.dart';
import 'package:my_finances/database/account_service.dart';
import 'package:my_finances/database/category_service.dart';
import 'package:my_finances/database/payment_service.dart';
import 'package:my_finances/main_app.dart';
import 'package:my_finances/models/account.dart';
import 'package:my_finances/models/category.dart';
import 'package:my_finances/models/payment.dart';
import 'package:my_finances/models/payment_status.dart';
import 'package:my_finances/models/recurrent_payment.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqlbrite/sqlbrite.dart';

Future<void> ensureDatabaseNotEmpty() async {
  final numberOfAccounts = 2;
  final numberOfCategories = 5;

  final numberOfExpenses = 2;
  final numberOfIncomes = 10;
  final numberOfAccountTransactions = 2;
  final numberOfCategoryTransactions = 2;

  final Random random = Random();

  if (await AccountService().getAll().isEmpty) {
    for (var index = 0; index < numberOfAccounts; index++) {
      AccountService().insert(
        Account(
          id: index + 1,
          name: "Cuenta ${index + 1}",
          description: "Descripción de la cuenta ${index + 1}",
          icon: Icons.account_balance.codePoint,
          image: "account.png",
          creationDate: DateTime.now(),
          showTheoreticalBalance: false,
          baseBalance: 0,
          lastChecked: DateTime.now(),
        ),
      );
    }
  }

  if (await CategoryService().getAll().isEmpty) {
    for (var index = 0; index < numberOfCategories; index++) {
      CategoryService().insert(
        Category(
          id: index + 1,
          name: "Categoría ${index + 1}",
          description: "Categoría de la cuenta ${index + 1}",
          icon: Icons.account_balance.codePoint,
          image: "category.png",
          creationDate: DateTime.now(),
          showTheoreticalBalance: false,
        ),
      );
    }
  }

  if (await PaymentService().getAll().isEmpty) {
    final amountsAndTypes = [
      (numberOfExpenses, "expense"),
      (numberOfIncomes, "income"),
      (numberOfAccountTransactions, "account-transation"),
      (numberOfCategoryTransactions, "category-transation"),
    ];
    for (final (index, data) in amountsAndTypes.indexed) {
      final (amount, type) = data;
      var paymentsSoFar = 0;
      for (var j = 0; j < index; j++) {
        final amount = amountsAndTypes[j].$1;
        paymentsSoFar += amount;
      }

      for (var j = 0; j < amount; j++) {
        final id = paymentsSoFar + j + 1;
        switch (type) {
          case "expense":
            PaymentService().insert(
              Payment(
                id: id,
                amount: 10,
                description: "Descripción del pago $id",
                creationDate: DateTime.now(),
                status: PaymentStatus.payed,
                destinationAccountId: null,
                destinationCategoryId: null,
                sourceAccountId: random.nextInt(numberOfAccounts) + 1,
                sourceCategoryId: random.nextInt(numberOfCategories) + 1,
              ),
            );
            break;
          default:
        }
      }
    }
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  databaseFactory = databaseFactoryFfi;

  if (isDevelopment) {
    //
  }

  runApp(const MainApp());
}
