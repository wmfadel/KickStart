import 'package:flutter/material.dart';
import 'package:kick_start/providers/leagues_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static final String routeName = '/home_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<LeaguesProvider>(context,listen: false).fetchLeaguesByCountries(),
        builder: (context, AsyncSnapshot<bool>snapshot){
         return snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data
              ?Consumer<LeaguesProvider>(
           builder: (ctx, provider, ch) => Column(
             children: <Widget>[
               ...provider.leagues.map((l) => Text(l.name)).toList()
             ],
           ),
         )
        : Center(child: CircularProgressIndicator());
        },
      )
    );
  }
}
