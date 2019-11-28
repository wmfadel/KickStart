import 'package:flutter/material.dart';

class LeagueDayMatchesScreen extends StatefulWidget {

  final Key key;
  LeagueDayMatchesScreen(this.key) : super(key: key);

  @override
  _LeagueDayMatchesScreenState createState() => _LeagueDayMatchesScreenState();
}

class _LeagueDayMatchesScreenState extends State<LeagueDayMatchesScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('day matches'),);
  }
}

