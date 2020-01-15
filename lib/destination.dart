import 'package:flutter/material.dart';

class Destination {
  const Destination(this.title, this.icon, this.color);
  final String title;
  final IconData icon;
  final MaterialColor color;
}

const List<Destination> allDestination = <Destination>[
  Destination('Match', Icons.calendar_today, Colors.blue),
  Destination('Standings', Icons.table_chart, Colors.cyan),
  Destination('Saved', Icons.save, Colors.orange),
];