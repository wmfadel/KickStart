import 'package:flutter/material.dart';
import 'package:kick_start/providers/fixtures_provider.dart';
import 'package:kick_start/screens/league_table.dart';
import 'package:provider/provider.dart';

import './league_day_matches_screen.dart';
import './league_ranking_screen.dart';
import './league_top_scorers_screen.dart';

class LeagueDetailsScreen extends StatefulWidget {
  static final String routeName = '/leaguedetailsscreen';

  @override
  _LeagueDetailsScreenState createState() => _LeagueDetailsScreenState();
}

class _LeagueDetailsScreenState extends State<LeagueDetailsScreen> {
  final PageStorageKey keyOne = PageStorageKey('leaguDayMatches');
  final PageStorageKey keyTwo = PageStorageKey('leagueRanking');
  final PageStorageKey keyThree = PageStorageKey('leagueTopScorers');
  final PageStorageKey keyFour = PageStorageKey('leagueAllMatches');
  final PageStorageBucket storageBucket = PageStorageBucket();
  int _navigationIndex = 0;
  Widget currentPage;
  LeagueDayMatchesScreen dayMatchesScreen;
  LeagueRankingScreen rankingScreen;
  LeagueTopScorersScreen topScorersScreen;
  LeagueTable leagueTable;
  List<Widget> pages;

  FixturesProvider _fixturesProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // fetching selected league
    int _leaagueId = ModalRoute.of(context).settings.arguments as int;

    // initializing screens data
    dayMatchesScreen = LeagueDayMatchesScreen(keyOne, _leaagueId);
    rankingScreen = LeagueRankingScreen(keyTwo, _leaagueId);
    topScorersScreen = LeagueTopScorersScreen(keyThree, _leaagueId);
    leagueTable = LeagueTable(keyFour, _leaagueId);
    pages = [dayMatchesScreen, rankingScreen, topScorersScreen, leagueTable];
    currentPage = pages[_navigationIndex];

    // creating streams for fixtures
    _fixturesProvider = FixturesProvider();
    _fixturesProvider.getPeriodicStream(_leaagueId);
  }

  @override
  void dispose() {
    super.dispose();
    _fixturesProvider.stopFetchingFixtures();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _fixturesProvider.stopFetchingFixtures();
        return true;
      },
      child: ChangeNotifierProvider(
        builder: (_) => _fixturesProvider,
        child: Scaffold(
          body: PageStorage(
            bucket: storageBucket,
            child: currentPage,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  backgroundColor: Colors.deepOrange,
                  icon: Icon(Icons.calendar_today),
                  title: Text('Today')),
              BottomNavigationBarItem(
                  backgroundColor: Colors.deepOrange,
                  icon: Icon(Icons.equalizer),
                  title: Text('Ranking')),
              BottomNavigationBarItem(
                backgroundColor: Colors.deepOrange,
                icon: Icon(Icons.supervisor_account),
                title: Text('Top scorers'),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.deepOrange,
                icon: Icon(Icons.table_chart),
                title: Text('Table'),
              ),
            ],
            currentIndex: _navigationIndex,
            onTap: (value) {
              setState(() {
                _navigationIndex = value;
                currentPage = pages[_navigationIndex];
              });
            },
          ),
        ),
      ),
    );
  }
}
