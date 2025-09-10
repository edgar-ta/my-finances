import 'package:my_finances/database/database_service.dart';
import 'package:my_finances/models/payment.dart';
import 'package:my_finances/models/payment_status.dart';
import 'package:sqflite_common/sqlite_api.dart';

class PaymentService with DatabaseService<Payment> {
  PaymentService._();
  static final _instance = PaymentService._();
  factory PaymentService() {
    return _instance;
  }

  @override
  String get tableName => 'Payment';

  @override
  Future<void> createTable(Database database) {
    return database.execute('''
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

  @override
  Payment entityFromMap(Map<String, dynamic> map) {
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

  @override
  Map<String, dynamic> entityToMap(Payment entity) {
    return {
      'id': entity.id,
      'source_category_id': entity.sourceCategoryId,
      'source_account_id': entity.sourceAccountId,
      'destination_category_id': entity.destinationCategoryId,
      'destination_account_id': entity.destinationAccountId,
      'amount': entity.amount,
      'description': entity.description,
      'creation_date': entity.creationDate.toIso8601String(),
      'status': entity.status.toDbString(),
      'parent_id': entity.parentId,
    };
  }
}
