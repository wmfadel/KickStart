import '.key.dart';

//  add a file named .key.dart to your lib folder
/*
    the file content should be like this and add your own api key

    class Keys{
      static final String API_KEY = 'YOUR_API_KEY';
    }

*/

class Environment {
  static final String API_BASE_URL =
      'https://api-football-v1.p.rapidapi.com/v2/';
  static final String countriesUrl = API_BASE_URL + 'countries';
  static final String seasonUrl = API_BASE_URL + 'seasons';
  static final String standingsUrl = API_BASE_URL + 'leagueTable';
  static final String topScorersUrl = API_BASE_URL + 'topscorers';
  static final String fixtureByLeagueUrl = API_BASE_URL + 'fixtures/league';
  static final String fixtureById = API_BASE_URL + 'fixtures/id';
  static final String statisticsById = API_BASE_URL + 'statistics/fixture';
  static final String lineupsUrl = API_BASE_URL + 'lineups';
  static final String eventsUrl = API_BASE_URL + 'events';
  static final String teamUrl = API_BASE_URL + 'teams/team';
  static final String coachUrl = API_BASE_URL + 'coachs/team';
  static final String coacTrophieshUrl = API_BASE_URL + 'trophies/coach';
  static final String squadUrl = API_BASE_URL + 'players/squad';
  static final String transfersUrl = API_BASE_URL + 'transfers/team';
  static final String statisticsUrl = API_BASE_URL + 'statistics';
  // Example URL: https://api-football-v1.p.rapidapi.com/v2/leagues/country/EG/2019
  static final String leaguesUrl = API_BASE_URL + 'leagues/country/';

  static final Map<String, String> requestHeaders = {
    'X-RapidAPI-Key': Keys.API_KEY,
    'Content-Type': 'application/json'
  };
}
