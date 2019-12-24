import 'package:flutter/material.dart';
import 'package:kick_start/providers/team_provider.dart';
import 'package:kick_start/widgets/team_coaches.dart';
import 'package:kick_start/widgets/team_squad.dart';
import 'package:kick_start/widgets/team_stats.dart';
import 'package:kick_start/widgets/team_transfers.dart';
import 'package:provider/provider.dart';

class TeamDetails extends StatefulWidget {
  static final String routeName = 'teamDetails';

  @override
  _TeamDetailsState createState() => _TeamDetailsState();
}

class _TeamDetailsState extends State<TeamDetails> {
  TeamProvider _teamProvider;
  final PageStorageKey keyOne = PageStorageKey('teamKey');
  final PageStorageKey keyTwo = PageStorageKey('squadKey');
  final PageStorageKey keyThree = PageStorageKey('traansfersKey');
  final PageStorageKey keyFour = PageStorageKey('coachesKey');
  final PageStorageBucket storageBucket = PageStorageBucket();
  int _navigationIndex = 0;
  Widget currentPage;
  TeamStats teamStats;
  TeamSquad teamSquad;
  TeamTransfers teamTransfers;
  TeamCoaches teamCoaches;
  List<Widget> pages;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Map<String, dynamic> params = ModalRoute.of(context).settings.arguments;
    if (params == null) Navigator.of(context).pop();

    teamStats = TeamStats(keyOne);
    teamSquad = TeamSquad(keyTwo);
    teamTransfers = TeamTransfers(keyThree, params['teamID']);
    teamCoaches = TeamCoaches(keyFour);
    pages = [teamStats, teamSquad, teamTransfers, teamCoaches];
    currentPage = pages[_navigationIndex];

    _teamProvider = Provider.of<TeamProvider>(context);
    _teamProvider.fetchTeam(params['teamID'], params['leagueID']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: storageBucket,
        child: currentPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              backgroundColor: Colors.deepOrange,
              icon: Icon(Icons.assessment),
              title: Text('Statistics')),
          BottomNavigationBarItem(
              backgroundColor: Colors.deepOrange,
              icon: Icon(Icons.people),
              title: Text('Squad')),
          BottomNavigationBarItem(
            backgroundColor: Colors.deepOrange,
            icon: Icon(Icons.compare_arrows),
            title: Text('Transferes'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.deepOrange,
            icon: Icon(Icons.assignment_ind),
            title: Text('Coaches'),
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
    );
  }
}
