import 'package:my_finances/database/database_service.dart';
import 'package:my_finances/models/category.dart';
import 'package:sqflite_common/sqlite_api.dart';

class CategoryService with DatabaseService<Category> {
  CategoryService._();
  static final _instance = CategoryService._();
  factory CategoryService() {
    return _instance;
  }

  @override
  String get tableName => 'Category';

  @override
  Future<void> createTable(Database database) {
    return database.execute("""
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

  @override
  Category entityFromMap(Map<String, dynamic> map) {
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

  @override
  Map<String, dynamic> entityToMap(Category entity) {
    return {
      'id': entity.id,
      'name': entity.name,
      'description': entity.description,
      'icon': entity.icon,
      'image': entity.image,
      'creation_date': entity.creationDate.toIso8601String(),
      'show_theoretical_balance': entity.showTheoreticalBalance ? 1 : 0,
    };
  }
}
