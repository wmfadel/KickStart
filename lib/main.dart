import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/countries_provider.dart';
import './providers/leagues_provider.dart';

import './screens/pick_country_screen.dart';
import './screens/home_screen.dart';
void main() {
 // Provider.debugCheckInvalidValueType = null;
  runApp(App());
}

class App extends StatelessWidget {
  final CountriesProvider _countriesProvider = CountriesProvider();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_) => _countriesProvider,
        ),
        ChangeNotifierProxyProvider<CountriesProvider, LeaguesProvider>(
            // Dependency injection
            builder: (context, country, oldLeagues) => LeaguesProvider(
                country.selectedCountries,
                oldLeagues == null ? [] : oldLeagues.leagues))
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
          HomePage.routeName: (context) => HomePage(),
        },
      ),
    );
  }
}
