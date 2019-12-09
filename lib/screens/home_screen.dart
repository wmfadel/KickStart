import 'package:flutter/material.dart';
import 'package:kick_start/screens/pick_country_screen.dart';
import 'package:provider/provider.dart';

import '../providers/leagues_provider.dart';
import '../widgets/league_item.dart';

class HomePage extends StatelessWidget {
  static final String routeName = '/home_page';

  @override
  Widget build(BuildContext context) {
    LeaguesProvider _leagueProvider =
        Provider.of<LeaguesProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Followed Leagues'),
        centerTitle: true,
       leading: IconButton(
         icon: Icon(Icons.flag,color: Colors.white),
         onPressed: (){
           Navigator.of(context).pop();
           Navigator.of(context).pushNamed(PickCountryScreen.routeName, arguments: true);
         },
       ),
      ),
      //drawer:AppDrawer(),

      body: ListView.builder(
        itemCount: _leagueProvider.leagues.length,
        itemBuilder: (BuildContext context, int index) =>
            LeagueItem(_leagueProvider.leagues[index]),
      ),
    );
  }
}
