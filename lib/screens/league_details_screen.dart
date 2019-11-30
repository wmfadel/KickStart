import 'package:flutter/material.dart';
import 'package:kick_start/providers/fixtures_provider.dart';
import 'package:provider/provider.dart';
import './league_day_matches_screen.dart';
import './league_ranking_screen.dart';
import './league_table_screen.dart';
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
  final PageStorageKey keyFour = PageStorageKey('leagueTable');
  final PageStorageBucket storageBucket = PageStorageBucket();
  int _navigationIndex = 0;
  Widget currentPage;
  LeagueDayMatchesScreen dayMatchesScreen;
  LeagueRankingScreen rankingScreen;
  LeagueTopScorersScreen topScorersScreen;
  LeagueTableScreen tableScreen;
  List<Widget> pages;

  FixturesProvider _fixturesProvider;

  @override
  void initState() {
    super.initState();
    dayMatchesScreen = LeagueDayMatchesScreen(keyOne);
    rankingScreen = LeagueRankingScreen(keyTwo);
    topScorersScreen = LeagueTopScorersScreen(keyThree);
    tableScreen = LeagueTableScreen(keyFour);
    pages = [dayMatchesScreen, rankingScreen, topScorersScreen, tableScreen];
    currentPage = pages[_navigationIndex];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fixturesProvider = Provider.of<FixturesProvider>(context, listen: false);
    _fixturesProvider.getPeriodicStream(972);
    _fixturesProvider.fixturesStream.listen((data){
      print(data[0].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        _fixturesProvider.cancelFixturesTimer();
        return true;
      },
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
              title: Text('top scorers'),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.deepOrange,
              icon: Icon(Icons.schedule),
              title: Text('table'),
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
    );
  }
}
