import 'package:flutter/material.dart';
import 'package:kick_start/providers/active_fixture_provider.dart';
import 'package:kick_start/providers/players_provider.dart';
import 'package:kick_start/providers/standings_provider.dart';
import 'package:kick_start/providers/teams_providers.dart';
import 'package:kick_start/providers/fixtures_provider.dart';
import 'package:kick_start/screens/fixture_details.dart';
import 'package:kick_start/screens/league_details_screen.dart';
import 'package:provider/provider.dart';

import './providers/countries_provider.dart';
import './providers/leagues_provider.dart';

import './screens/pick_country_screen.dart';
import './screens/pick_league_screen.dart';
import './screens/home_screen.dart';

void main() {
  // Provider.debugCheckInvalidValueType = null;
  runApp(App());
}

class App extends StatelessWidget {
  final CountriesProvider _countriesProvider = CountriesProvider();
  final LeaguesProvider _leaguesProvider = LeaguesProvider();
  final StandingsProvider _standingsProvider = StandingsProvider();
  final TeamsProvider _teamsProvider = TeamsProvider();
  final FixturesProvider _fixturesProvider = FixturesProvider();
  final ActiveFixtureProvider _activeFixtureProvider = ActiveFixtureProvider();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_) => _countriesProvider,
        ),
        ChangeNotifierProvider(
          builder: (_) => _leaguesProvider,
        ),
        ChangeNotifierProvider(
          builder: (_) => _standingsProvider,
        ),
        ChangeNotifierProvider(
          builder: (_) => _teamsProvider,
        ),
        ChangeNotifierProxyProvider<StandingsProvider, PlayersProvider>(builder:
            (BuildContext context, StandingsProvider standingsProvider,
            PlayersProvider oldPlayersProvider) {
          return PlayersProvider(
              oldPlayersProvider == null ? [] : oldPlayersProvider.topScorers,
              standingsProvider.fetchStandingsForLeague,
              standingsProvider.standings);
        }),
        ChangeNotifierProvider(
          builder: (_) => _fixturesProvider,
        ),
        ChangeNotifierProvider(
          builder: (_) => _activeFixtureProvider,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          textTheme: TextTheme(
            title: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            body1: TextStyle(
              color: Colors.black54,
              fontSize: 20,
            ),
            body2: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
        initialRoute: PickCountryScreen.routeName,
        routes: {
          PickCountryScreen.routeName: (context) => PickCountryScreen(),
          PickLeagueScreen.routeName: (context) => PickLeagueScreen(),
          HomePage.routeName: (context) => HomePage(),
          LeagueDetailsScreen.routeName: (context) => LeagueDetailsScreen(),
          FixtureDetails.routeName: (context) => FixtureDetails(),
        },
      ),
    );
  }
}
