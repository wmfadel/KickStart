import 'package:flutter/material.dart';
import 'package:kick_start/models/fixture.dart';
import 'package:kick_start/providers/fixtures_provider.dart';
import 'package:provider/provider.dart';

class LeagueDayMatchesScreen extends StatefulWidget {
  final Key key;
  final int leagueId;
  LeagueDayMatchesScreen(this.key, this.leagueId) : super(key: key);

  @override
  _LeagueDayMatchesScreenState createState() => _LeagueDayMatchesScreenState();
}

class _LeagueDayMatchesScreenState extends State<LeagueDayMatchesScreen> {
  FixturesProvider _fixturesProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fixturesProvider = Provider.of<FixturesProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Fixture>>(
      stream: _fixturesProvider.fixturesStream,
      builder: (BuildContext context, AsyncSnapshot<List<Fixture>> snapshot) {
        if (snapshot.hasError)
          return Center(
            child: Text('error'),
          );
        if (snapshot.hasData && snapshot.data[0].leagueId==widget.leagueId) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, index) {
              return ListTile(
                title: Text(snapshot.data[index].homeTeam.teamName),
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
