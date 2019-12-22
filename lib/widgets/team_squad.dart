import 'package:flutter/material.dart';

class TeamSquad extends StatelessWidget {

  final Key key;
  TeamSquad(this.key) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('squad'),),
    );
  }
}