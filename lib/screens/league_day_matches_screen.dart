import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';
import 'package:kick_start/models/fixture.dart';
import 'package:kick_start/providers/fixtures_provider.dart';
import 'package:kick_start/widgets/fixture_item.dart';
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
  String _flareFile = 'assets/flare/heart.flr';
  String _flareAnimation = 'Heart Break';



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
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width*0.8,
                  height: 300,
                  child: FlareActor(_flareFile,
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                      animation: _flareAnimation,callback: (_){
                    setState(() {
                      _flareFile = "assets/flare/empty.flr";
                      _flareAnimation = 'empty';
                    });
                    },),
                ),
                SizedBox(height: 20),
                Text('No matches today',textAlign:TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 24),)
              ],
            ),
          );
        if (snapshot.hasData && snapshot.data[0].leagueId==widget.leagueId) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, index) {
              return FixtureItem(snapshot.data[index]);
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
