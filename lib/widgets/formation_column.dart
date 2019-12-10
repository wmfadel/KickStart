import 'package:flutter/material.dart';
import '../models/formation.dart';

class FormationColumn extends StatelessWidget {
  final TeamData teamData;

  FormationColumn(this.teamData);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          if(teamData.formation != null)
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: 45,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Text(
              teamData.formation,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.deepOrange.withOpacity(0.8),
            ),
          ),
          Divider(),
          ListTile(
            title: Text(teamData.coach),
            subtitle: Text('Coach'),
            leading: CircleAvatar(
              child: Text('C'),
              backgroundColor: Colors.black,
            ),
          ),
          Divider(),
          Text(
            'Main Team',
            style: TextStyle(color: Colors.black),
          ),
          ...teamData.startXI.map((StartXI player) {
            return ListTile(
              title: Text(player.player),
              leading: CircleAvatar(
                child: Text(
                  player.pos??'P',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: getPosColor(player.pos),
              ),
              trailing: CircleAvatar(
                child: Text(
                  '${player.number??''}',
                  style: TextStyle(color: Colors.black),
                ),
                backgroundColor: Colors.white,
              ),
            );
          }).toList(),
          Divider(),

          if(teamData.substitutes != null && teamData.substitutes.length > 1)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              'Substitutes',
              style: TextStyle(color: Colors.black),
            ),
          ),
          if(teamData.substitutes != null && teamData.substitutes.length > 1)
          ...teamData.substitutes.map((StartXI player) {
            return ListTile(
              title: Text(player.player),
              leading: CircleAvatar(
                child: Text(
                  player.pos??'P',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: getPosColor(player.pos??' '),
              ),
              trailing: CircleAvatar(
                child: Text(
                  '${player.number??''}',
                  style: TextStyle(color: Colors.black),
                ),
                backgroundColor: Colors.white12,
              ),
            );
          }).toList()
        ],
      ),
    );
  }

  Color getPosColor(String pos) {
    switch (pos) {
      case 'G':
        return Colors.blue;
      case 'D':
        return Colors.green;
      case 'M':
        return Colors.amber;
      default:
        return Colors.deepOrange;
    }
  }
}
