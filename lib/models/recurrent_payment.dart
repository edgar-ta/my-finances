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
  final Duration step; // cambiado a Duration

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

  factory RecurrentPayment.fromMap(Map<String, dynamic> map) {
    return RecurrentPayment(
      id: map['id'] as int,
      sourceCategoryId: map['source_category_id'] as int?,
      sourceAccountId: map['source_account_id'] as int?,
      destinationCategoryId: map['destination_category_id'] as int?,
      destinationAccountId: map['destination_account_id'] as int?,
      amount: (map['amount'] as num).toDouble(),
      description: map['description'] as String,
      creationDate: DateTime.parse(map['creation_date'] as String),
      startDate: DateTime.parse(map['start_date'] as String),
      endDate:
          map['end_date'] != null
              ? DateTime.parse(map['end_date'] as String)
              : null,
      step: Duration(seconds: map['step'] as int), // reconstrucción desde int
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'source_category_id': sourceCategoryId,
      'source_account_id': sourceAccountId,
      'destination_category_id': destinationCategoryId,
      'destination_account_id': destinationAccountId,
      'amount': amount,
      'description': description,
      'creation_date': creationDate.toIso8601String(),
      'start_date': startDate.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'step': step.inSeconds, // guardamos en segundos en SQLite
    };
  }

  static Future<void> createTable(Database db) async {
    return db.execute('''
CREATE TABLE RecurrentPayment (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  source_category_id INTEGER,
  source_account_id INTEGER,
  destination_category_id INTEGER,
  destination_account_id INTEGER,
  amount REAL NOT NULL,
  description TEXT NOT NULL,
  creation_date TEXT NOT NULL,
  start_date TEXT NOT NULL,
  end_date TEXT,
  step INTEGER NOT NULL
)
''');
  }
}
