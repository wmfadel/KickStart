import 'package:flutter/material.dart';
import 'package:kick_start/models/fixture.dart';
import 'package:kick_start/providers/active_fixture_provider.dart';
import 'package:provider/provider.dart';

class FixtureDetails extends StatefulWidget {
  static final String routeName = 'fixtureDetails';

  @override
  _FixtureDetailsState createState() => _FixtureDetailsState();
}

class _FixtureDetailsState extends State<FixtureDetails> {

  ActiveFixtureProvider _activeFixtureProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _activeFixtureProvider = Provider.of<ActiveFixtureProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Fixture>(
        stream: _activeFixtureProvider.currentFixtureStream,
        builder: (BuildContext context, AsyncSnapshot<Fixture> snapShot) {
          return snapShot.hasData
              ? Center(child: Text(snapShot.data.homeTeam.teamName??'blah'))
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
