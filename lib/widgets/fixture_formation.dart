import 'package:flutter/material.dart';
import 'package:kick_start/models/formation.dart';
import 'package:kick_start/providers/active_fixture_provider.dart';
import 'package:provider/provider.dart';

class FixtureFormation extends StatefulWidget {
  @override
  _FixtureFormationState createState() => _FixtureFormationState();
}

class _FixtureFormationState extends State<FixtureFormation> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Formation>(
      stream: Provider.of<ActiveFixtureProvider>(context).currentFormationStream,
      builder: (BuildContext context, AsyncSnapshot<Formation> snapshot){
        if(snapshot.hasError)
          return Center(child: Text(snapshot.error));
        return snapshot.hasData?
            Center(child: Text(snapshot.data.homeTeam.coach),):
            CircularProgressIndicator();
      },
    );
  }
}
