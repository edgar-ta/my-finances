import 'package:sqflite/sqflite.dart';

class Account {
  final int id;
  final String name;
  final String description;
  final int icon; // representamos IconType como un int (codePoint)
  final String image; // ruta de la imagen
  final DateTime creationDate;
  final bool showTheoreticalBalance;
  final double baseBalance;
  final DateTime lastChecked;

  Account({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.image,
    required this.creationDate,
    required this.showTheoreticalBalance,
    required this.baseBalance,
    required this.lastChecked,
  });

  factory Account.fromMap(Map<String, dynamic> map) {
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon': icon,
      'image': image,
      'creation_date': creationDate.toIso8601String(),
      'show_theoretical_balance': showTheoreticalBalance ? 1 : 0,
      'base_balance': baseBalance,
      'last_checked': lastChecked.toIso8601String(),
    };
  }

  static Future<void> createTable(Database db) async {
    return db.execute('''
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
