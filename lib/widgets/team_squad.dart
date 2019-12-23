import 'package:flutter/material.dart';
import 'package:kick_start/models/player.dart';
import 'package:kick_start/providers/team_provider.dart';
import 'package:kick_start/widgets/flare_error_widget.dart';
import 'package:kick_start/widgets/player_item.dart';
import 'package:provider/provider.dart';

class TeamSquad extends StatelessWidget {
  final Key key;
  TeamSquad(this.key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Player>>(
      stream: Provider.of<TeamProvider>(context).squadStream,
      builder: (BuildContext context, AsyncSnapshot<List<Player>> snapshot) {
        if (snapshot.hasError) return Center(child: FlareErrorWidget(snapshot.error));
        if (snapshot.hasData && snapshot.data != null) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) =>
                PlayerItem(snapshot.data[index]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
