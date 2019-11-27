import 'package:flutter/material.dart';
import 'package:kick_start/models/league.dart';
import 'package:kick_start/widgets/league_item.dart';
import '../providers/countries_provider.dart';
import '../providers/leagues_provider.dart';
import 'package:provider/provider.dart';

class PickLeagueScreen extends StatelessWidget {
  static final String routeName = '/pickleagues';

  @override
  Widget build(BuildContext context) {
    String selectedCountryCode =
        ModalRoute.of(context).settings.arguments as String;
    CountriesProvider _countriesProvider =
        Provider.of<CountriesProvider>(context, listen: false);
    LeaguesProvider _leaguesProvider =
        Provider.of<LeaguesProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            _countriesProvider.getCountryByCode(selectedCountryCode).country),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _leaguesProvider.fetchLeaguesByCountry(
            _countriesProvider.getCountryByCode(selectedCountryCode)),
        builder: (BuildContext context, AsyncSnapshot<List<League>> snapshot) {
          return snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData
              ? Consumer<LeaguesProvider>(
                  builder: (ctx, provider, ch) => ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) =>
                        LeagueItem(snapshot.data[index]),
                  ),
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
