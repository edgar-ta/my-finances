import 'package:my_finances/models/serializable.dart';
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
}
