import 'package:flutter/material.dart';

class LeagueTableScreen extends StatefulWidget {
  final Key key;

  LeagueTableScreen(this.key) : super(key: key);

  @override
  _LeagueTableScreenState createState() => _LeagueTableScreenState();
}

class _LeagueTableScreenState extends State<LeagueTableScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('table'),
    );
  }
}
