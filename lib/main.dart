import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_finances/control_variables.dart';
import 'package:my_finances/database/account_service.dart';
import 'package:my_finances/database/category_service.dart';
import 'package:my_finances/database/payment_service.dart';
import 'package:my_finances/database/recurrent_payment_service.dart';
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

Future<void> populateAccounts(int numberOfAccounts) async {
  if (await AccountService().getAll().isEmpty) {
    for (var index = 0; index < numberOfAccounts; index++) {
      await AccountService().insert(
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
}

Future<void> populateCategories(int numberOfCategories) async {
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
}

Future<void> populatePayments(
  int numberOfAccounts,
  int numberOfCategories,
  int numberOfExpenses,
  int numberOfIncomes,
  int numberOfAccountTransactions,
  int numberOfCategoryTransactions,
) async {
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
        int? destinationAccountId;
        int? destinationCategoryId;
        int? sourceAccountId;
        int? sourceCategoryId;
        switch (type) {
          case "expense":
            destinationAccountId = null;
            destinationCategoryId = null;
            sourceAccountId = randomInt(
              max: numberOfAccounts,
              min: 1,
              inclusive: true,
            );
            sourceCategoryId = randomInt(
              max: numberOfCategories,
              min: 1,
              inclusive: true,
            );
            break;
          case "income":
            sourceAccountId = null;
            sourceCategoryId = null;
            destinationAccountId = randomInt(
              max: numberOfAccounts,
              min: 1,
              inclusive: true,
            );
            destinationCategoryId = randomInt(
              max: numberOfCategories,
              min: 1,
              inclusive: true,
            );
            break;
          case "account-transaction":
            sourceCategoryId = randomInt(
              max: numberOfCategories,
              min: 1,
              inclusive: true,
            );
            destinationCategoryId = sourceCategoryId;

            (sourceAccountId, destinationAccountId) = randomPair(
              max: numberOfAccounts,
              min: 1,
              inclusive: true,
            );
            sourceAccountId++;
            destinationAccountId++;
            break;
          case "category-transaction":
            sourceAccountId = randomInt(
              max: numberOfAccounts,
              min: 1,
              inclusive: true,
            );
            destinationAccountId = sourceAccountId;

            (sourceCategoryId, destinationCategoryId) = randomPair(
              max: numberOfCategories,
              min: 1,
              inclusive: true,
            );
            sourceCategoryId++;
            destinationCategoryId++;
            break;
        }
        PaymentService().insert(
          Payment(
            id: id,
            amount: randomInt(max: 100, min: 10).toDouble(),
            description: "Descripción del pago $id",
            creationDate: DateTime.now(),
            status:
                PaymentStatus.values[randomInt(
                  max: PaymentStatus.values.length,
                )],
            destinationAccountId: destinationAccountId,
            destinationCategoryId: destinationCategoryId,
            sourceAccountId: sourceAccountId,
            sourceCategoryId: sourceCategoryId,
          ),
        );
      }
    }
  }
}

Future<void> populateRecurrentPayments(int numberOfRecurrentPayments) async {
  if (!(await RecurrentPaymentService().getAll().isEmpty)) {
    return;
  }

  for (var i = 0; i < numberOfRecurrentPayments; i++) {
    final id = i + 1;
    RecurrentPaymentService().insert(
      RecurrentPayment(
        id: id,
        amount: 50,
        description: "Descripción del pago recurrente $id",
        creationDate: DateTime.now(),
        startDate: DateTime.now().add(
          Duration(days: randomInt(max: 7, min: 1, inclusive: true)),
        ),
        step: Duration(hours: randomInt(max: 48, min: 1, inclusive: true)),
      ),
    );
  }
}

Future<void> ensureDatabaseNotEmpty() async {
  final numberOfAccounts = 2;
  final numberOfCategories = 5;

  final numberOfExpenses = 2;
  final numberOfIncomes = 10;
  final numberOfAccountTransactions = 2;
  final numberOfCategoryTransactions = 2;

  final numberOfRecurrentPayments = 2;

  await populateAccounts(numberOfAccounts);
  await populateCategories(numberOfCategories);
  await populatePayments(
    numberOfAccounts,
    numberOfCategories,
    numberOfExpenses,
    numberOfIncomes,
    numberOfAccountTransactions,
    numberOfCategoryTransactions,
  );
  await populateRecurrentPayments(numberOfRecurrentPayments);
}

int randomInt({required int max, int min = 0, bool inclusive = false}) {
  final Random random = Random();
  var value = random.nextInt((max - min) + (inclusive ? 1 : 0)) + min;
  return value;
}

(int, int) randomPair({required int max, int min = 0, bool inclusive = false}) {
  if (max == 1) {
    throw ArgumentError("El valor máximo debe ser mayor a 1");
  }
  int first = randomInt(max: max, min: min, inclusive: inclusive);
  int second = first;
  while (second == first) {
    second = randomInt(max: max, min: min, inclusive: inclusive);
  }
  return (first, second);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  databaseFactory = databaseFactoryFfi;

  if (isDevelopment) {
    await ensureDatabaseNotEmpty();
  }

  runApp(const MainApp());
}
