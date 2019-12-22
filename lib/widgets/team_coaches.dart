import 'package:flutter/material.dart';

class TeamCoaches extends StatelessWidget {

  final Key key;
  TeamCoaches(this.key) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('Coaches'),),
    );
  }
}