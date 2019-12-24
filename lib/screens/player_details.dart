import 'package:flutter/material.dart';

class PlayerDetails extends StatefulWidget {
  static final String routeName = 'playerDetails';
  @override
  _PlayerDetailsState createState() => _PlayerDetailsState();
}

class _PlayerDetailsState extends State<PlayerDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Player details')),
    );
  }
}
