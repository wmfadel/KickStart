import 'package:flutter/material.dart';
import 'package:kick_start/models/country.dart';
import 'package:provider/provider.dart';

import '../providers/leagues_provider.dart';
import '../widgets/league_item.dart';

class HomePage extends StatelessWidget {
  static final String routeName = '/home_page';

  @override
  Widget build(BuildContext context) {
    print(DateTime.now().toString());
    return Scaffold(
    /*  body: FutureBuilder(
        future: Provider.of<LeaguesProvider>(context, listen: false)
            .fetchLeaguesByCountry(Country()),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          return snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData &&
                  snapshot.data
              ? Consumer<LeaguesProvider>(
                  builder: (ctx, provider, ch) => ListView.builder(
                    itemCount: provider.leagues.length,
                    itemBuilder: (BuildContext context, int index) =>
                        LeagueItem(provider.leagues[index]),
                  ),
                )
              : Center(child: CircularProgressIndicator());
        },
      ),*/
    );
  }
}
