import 'package:flutter/material.dart';
import 'package:kick_start/models/league.dart';
import 'package:kick_start/providers/auth_provider.dart';
import 'package:kick_start/widgets/league_item.dart';
import '../providers/countries_provider.dart';
import '../providers/leagues_provider.dart';
import 'package:provider/provider.dart';

class PickLeagueScreen extends StatefulWidget {
  static final String routeName = '/pickleagues';

  @override
  _PickLeagueScreenState createState() => _PickLeagueScreenState();
}

class _PickLeagueScreenState extends State<PickLeagueScreen> {
  CountriesProvider _countriesProvider;
  LeaguesProvider _leaguesProvider;
  String selectedCountryCode;
  Future<List<League>> leagueFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _countriesProvider = Provider.of<CountriesProvider>(context, listen: false);
    _leaguesProvider = Provider.of<LeaguesProvider>(context, listen: false);
    selectedCountryCode = ModalRoute.of(context).settings.arguments as String;
    if (leagueFuture == null)
      leagueFuture = _leaguesProvider.fetchLeaguesByCountry(
          _countriesProvider.getCountryByCode(selectedCountryCode));
  }

  @override
  Widget build(BuildContext context) {
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
        future: leagueFuture,
        builder: (BuildContext context, AsyncSnapshot<List<League>> snapshot) {
          return snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) =>
                      LeagueItem(snapshot.data[index], isSelecting: true,),
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
