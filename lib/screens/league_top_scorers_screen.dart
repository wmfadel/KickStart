import 'package:flutter/material.dart';

class LeagueTopScorersScreen extends StatefulWidget {

  final Key key;
  LeagueTopScorersScreen(this.key) : super(key: key);

  @override
  _LeagueTopScorersScreenState createState() => _LeagueTopScorersScreenState();
}

class _LeagueTopScorersScreenState extends State<LeagueTopScorersScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('top scorers'),);
  }
}
