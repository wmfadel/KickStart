import 'package:flutter/material.dart';
import 'package:kick_start/models/coach.dart';

class CoachItem extends StatelessWidget {
  final Coach coach;
  CoachItem(this.coach);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Material(
        color: Colors.white,
        elevation: 10,
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.hardEdge,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 220,
          child: Column(
            children: <Widget>[
              
            ],
          ),
        ),
      ),
    );
  }
}
