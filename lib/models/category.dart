import 'package:sqflite/sqflite.dart';

class Category {
  final int id;
  final String name;
  final String description;
  final int icon; // codePoint del icono
  final String image;
  final DateTime creationDate;
  final bool showTheoreticalBalance;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.image,
    required this.creationDate,
    required this.showTheoreticalBalance,
  });

  /// Convierte un Map (de SQLite) a un objeto Category
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      icon: map['icon'] as int,
      image: map['image'] as String,
      creationDate: DateTime.parse(map['creation_date'] as String),
      showTheoreticalBalance: (map['show_theoretical_balance'] as int) == 1,
    );
  }

  /// Convierte un objeto Category a Map (para guardarlo en SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon': icon,
      'image': image,
      'creation_date': creationDate.toIso8601String(),
      'show_theoretical_balance': showTheoreticalBalance ? 1 : 0,
    };
  }

  static Future<void> createTable(Database db) async {
    return db.execute("""
CREATE TABLE category (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    description TEXT,
    icon_type INTEGER NOT NULL,
    image TEXT,
    creation_date TEXT NOT NULL,
    show_theoretical_balance INTEGER NOT NULL DEFAULT 0
)
""");
  }
}
