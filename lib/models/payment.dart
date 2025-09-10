import 'package:my_finances/models/payment_status.dart';
import 'package:my_finances/models/serializable.dart';
import 'package:sqflite/sqflite.dart';

class Payment {
  final int id;
  final int? sourceCategoryId;
  final int? sourceAccountId;
  final int? destinationCategoryId;
  final int? destinationAccountId;
  final double amount;
  final String description;
  final DateTime creationDate;
  final PaymentStatus status;
  final String? parentId; // referencia a RecurrentPayment

  Payment({
    required this.id,
    this.sourceCategoryId,
    this.sourceAccountId,
    this.destinationCategoryId,
    this.destinationAccountId,
    required this.amount,
    required this.description,
    required this.creationDate,
    required this.status,
    this.parentId,
  });
}
