import 'package:flutter/material.dart';
import 'package:kick_start/models/transfer.dart';
import 'package:kick_start/providers/team_provider.dart';
import 'package:provider/provider.dart';

class TeamTransfers extends StatelessWidget {
  final Key key;
  TeamTransfers(this.key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Transfer>>(
      stream: Provider.of<TeamProvider>(context).transfersStream,
      builder: (BuildContext context, AsyncSnapshot<List<Transfer>> snapshot) {
        if (snapshot.hasError) return Center(child: Text(snapshot.error));
        return snapshot.hasData
            ? Container()
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  
}
