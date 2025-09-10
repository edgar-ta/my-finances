import 'package:my_finances/models/serializable.dart';
import 'package:sqflite/sqflite.dart';

class RecurrentPayment {
  final int id;
  final int? sourceCategoryId;
  final int? sourceAccountId;
  final int? destinationCategoryId;
  final int? destinationAccountId;
  final double amount;
  final String description;
  final DateTime creationDate;
  final DateTime startDate;
  final DateTime? endDate;
  final Duration step;

  RecurrentPayment({
    required this.id,
    this.sourceCategoryId,
    this.sourceAccountId,
    this.destinationCategoryId,
    this.destinationAccountId,
    required this.amount,
    required this.description,
    required this.creationDate,
    required this.startDate,
    this.endDate,
    required this.step,
  });
}
