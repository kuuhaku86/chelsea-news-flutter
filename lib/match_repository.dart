import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MatchRepository with ChangeNotifier {
  List <TeamStanding> _standings = [];
  List <LeagueMatch> _matches = [];
  List <LeagueMatch> _privateMatchs = [];
  
  List get standings => _standings;
  List get matchs => _matches;
  List get privateMatchs => _privateMatchs;

  Future<void> getStandings() async {
    try {
      Response response = await Dio().get(
        'https://api.football-data.org/v2/competitions/PL/standings',
        options: Options(
          headers: {"X-Auth-Token" : "0efefcbdc5d349edb1464616a9f4048d"}
        )
      );
      
      _standings.clear();

      for (var team in response.data["standings"][0]["table"]) {
        _standings.add(TeamStanding(
          image: team["team"]["crestUrl"].toString(),
          name: team["team"]["name"].toString(),
          win: team["won"].toString(),
          draw: team["draw"].toString(),
          lose: team["lost"].toString(),
          goalDifference: team["goalDifference"].toString(),
          point: team["points"].toString()
          )
        );
      }
      notifyListeners();
    }catch(e){
      print(e);
    }
  }

  Future<void> getMatches() async {
    try {
      Response response = await Dio().get(
        'https://api.football-data.org/v2/teams/61/matches?status=SCHEDULED',
        options: Options(
          headers: {"X-Auth-Token" : "0efefcbdc5d349edb1464616a9f4048d"}
        )
      );
      
      _matches.clear();

      for (var match in response.data["matches"]) {
        _matches.add(
          LeagueMatch(
            enemy: match["homeTeam"]["name"] != "Chelsea FC"? match["homeTeam"]["name"] : match["awayTeam"]["name"],
            week: match["season"]["currentMatchday"].toString(),
            time: match["utcDate"]
          ),
        );
      }
      notifyListeners();
    }catch(e){
      print(e);
    }
  }
}

class TeamStanding {
  final String name,
    image,
    win,
    lose,
    draw,
    goalDifference,
    point;
  TeamStanding({this.image, this.name, this.win, this.lose, this.draw, this.goalDifference, this.point});
}

class LeagueMatch {
  final String enemy,
    week,
    time;
  LeagueMatch({this.enemy, this.week, this.time});
}