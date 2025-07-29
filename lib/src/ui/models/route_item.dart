import 'package:flutter/widgets.dart';

class RouteItem {
  final String Function(BuildContext) getTitle;
  final String routeName;
  final IconData icon;

  RouteItem(this.getTitle, this.routeName, this.icon);
}