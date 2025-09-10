import 'package:my_finances/database/database_helper.dart';
import 'package:my_finances/database/database_service.dart';
import 'package:my_finances/main.dart';
import 'package:my_finances/models/account.dart';
import 'package:sqlbrite/sqlbrite.dart';

class AccountService with DatabaseService<Account> {
  AccountService._();
  static final _instance = AccountService._();
  factory AccountService() {
    return _instance;
  }

  @override
  String get tableName => 'Account';

  @override
  Account entityFromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      icon: map['icon'] as int,
      image: map['image'] as String,
      creationDate: DateTime.parse(map['creation_date'] as String),
      showTheoreticalBalance: (map['show_theoretical_balance'] as int) == 1,
      baseBalance: (map['base_balance'] as num).toDouble(),
      lastChecked: DateTime.parse(map['last_checked'] as String),
    );
  }

  @override
  Map<String, dynamic> entityToMap(Account entity) {
    return {
      'id': entity.id,
      'name': entity.name,
      'description': entity.description,
      'icon': entity.icon,
      'image': entity.image,
      'creation_date': entity.creationDate.toIso8601String(),
      'show_theoretical_balance': entity.showTheoreticalBalance ? 1 : 0,
      'base_balance': entity.baseBalance,
      'last_checked': entity.lastChecked.toIso8601String(),
    };
  }

  @override
  Future<void> createTable(Database database) {
    return database.execute('''
CREATE TABLE Account (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  icon INTEGER NOT NULL,
  image TEXT NOT NULL,
  creation_date TEXT NOT NULL,
  show_theoretical_balance INTEGER NOT NULL,
  base_balance REAL NOT NULL,
  last_checked TEXT NOT NULL
)
''');
  }
}
