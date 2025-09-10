import 'package:my_finances/database/database_service.dart';
import 'package:my_finances/models/recurrent_payment.dart';
import 'package:sqflite_common/sqlite_api.dart';

class RecurrentPaymentService with DatabaseService<RecurrentPayment> {
  RecurrentPaymentService._();
  static final _instance = RecurrentPaymentService._();
  factory RecurrentPaymentService() {
    return _instance;
  }

  @override
  String get tableName => 'RecurrentPayment';

  @override
  Future<void> createTable(Database database) {
    return database.execute('''
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

  @override
  RecurrentPayment entityFromMap(Map<String, dynamic> map) {
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

  @override
  Map<String, dynamic> entityToMap(RecurrentPayment entity) {
    return {
      'id': entity.id,
      'source_category_id': entity.sourceCategoryId,
      'source_account_id': entity.sourceAccountId,
      'destination_category_id': entity.destinationCategoryId,
      'destination_account_id': entity.destinationAccountId,
      'amount': entity.amount,
      'description': entity.description,
      'creation_date': entity.creationDate.toIso8601String(),
      'start_date': entity.startDate.toIso8601String(),
      'end_date': entity.endDate?.toIso8601String(),
      'step': entity.step.inSeconds, // guardamos en segundos en SQLite
    };
  }
}
