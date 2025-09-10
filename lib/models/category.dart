import 'package:my_finances/models/serializable.dart';
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
}
