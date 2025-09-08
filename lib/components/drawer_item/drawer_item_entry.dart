import 'package:flutter/widgets.dart';

class DrawerItemEntry {
  final String route;
  final List<DrawerItemEntry> subroutes;
  final bool navigatable;
  final String title;
  final IconData? icon;

  DrawerItemEntry({
    required this.route,
    required this.subroutes,
    required this.navigatable,
    required this.title,
    this.icon,
  });
}
