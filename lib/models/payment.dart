import 'package:my_finances/models/payment_status.dart';
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

  /// Convierte un Map (SQLite) a objeto Payment
  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      id: map['id'] as int,
      sourceCategoryId: map['source_category_id'] as int?,
      sourceAccountId: map['source_account_id'] as int?,
      destinationCategoryId: map['destination_category_id'] as int?,
      destinationAccountId: map['destination_account_id'] as int?,
      amount: (map['amount'] as num).toDouble(),
      description: map['description'] as String,
      creationDate: DateTime.parse(map['creation_date'] as String),
      status: PaymentStatusExtension.fromDbString(map['status'] as String),
      parentId: map['parent_id'] as String?,
    );
  }

  /// Convierte un Payment a Map (para guardar en SQLite)
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
      'status': status.toDbString(),
      'parent_id': parentId,
    };
  }

  static Future<void> createTable(Database db) async {
    return db.execute('''
CREATE TABLE payment (
    id INTEGER PRIMARY KEY,
    source_category_id INTEGER,
    source_account_id INTEGER,
    destination_category_id INTEGER,
    destination_account_id INTEGER,
    amount REAL NOT NULL,
    description TEXT NOT NULL,
    creation_date TEXT NOT NULL,
    status TEXT NOT NULL,
    parent_id TEXT,
    FOREIGN KEY (source_category_id) REFERENCES category(id),
    FOREIGN KEY (destination_category_id) REFERENCES category(id),
    FOREIGN KEY (source_account_id) REFERENCES account(id),
    FOREIGN KEY (destination_account_id) REFERENCES account(id),
    FOREIGN KEY (parent_id) REFERENCES recurrent_payment(id)
)
''');
  }
}
