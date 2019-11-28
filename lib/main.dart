import 'package:flutter/material.dart';
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
        },
      ),
    );
  }
}
