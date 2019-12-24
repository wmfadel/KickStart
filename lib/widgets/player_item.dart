import 'package:flutter/material.dart';
import 'package:kick_start/models/player.dart';
import 'package:kick_start/screens/player_details.dart';

class PlayerItem extends StatelessWidget {
  final Player player;

  PlayerItem(this.player);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
       /* Navigator.of(context)
            .pushNamed(PlayerDetails.routeName, arguments: player.playerId);*/
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Material(
          elevation: 10,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          clipBehavior: Clip.hardEdge,
          child: Container(
            width: size.width,
            height: 235,
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  player.playerName,
                  style: TextStyle(color: Colors.black, fontSize: 28),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${player.firstname ?? ''} ${player.lastname ?? ''}',
                  style: TextStyle(fontSize: 18),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Divider(),
                SizedBox(height: 4),
                Text(
                    '${player.position == null ? '' : '${player.position},'} ${player.age == null ? '' : '${player.age} years'}',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                if (player.birthDate != null)
                  Text('Birthdate: ${player.birthDate}',
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                if (player.birthPlace != null)
                  Text(
                    'Birth place: ${player.birthPlace}, ${player.birthCountry ?? ''}',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (player.nationality != null)
                  Text('Nationality: ${player.nationality}',
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Text('Weight: ${player.weight ?? 'unknown'}',
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                    ),
                    Expanded(
                      child: Text('Height: ${player.height ?? 'unknown'}',
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
