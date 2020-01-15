import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MatchRepository with ChangeNotifier {
  List <TeamStanding> _standings;
  List <LeagueMatch> _matchs;
  List <LeagueMatch> _privateMatchs;
  
  List get standings => _standings;
  List get matchs => _matchs;
  List get privateMatchs => _privateMatchs;

  Future<void> getStandings() async {
    try {
      Response response = await Dio().get(
        'https://api.football-data.org/v2/competitions/PL/standings',
        options: Options(
          headers: {"X-Auth-Token" : "0efefcbdc5d349edb1464616a9f4048d"}
        )
      );
      
      for (var team in response.data["standings"][0]["table"]) {
        _standings.add(TeamStanding(
          image: team["cestUrl"].toString(),
          name: team["name"].toString(),
          win: team["won"].toString(),
          draw: team["draw"].toString(),
          lose: team["lost"].toString(),
          goalDifference: team["goalDifference"].toString(),
          point: team["points"].toString()
          )
        );
      }

      print(standings);
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
  final String homeName,
    awayName,
    week;
  LeagueMatch({this.homeName, this.awayName, this.week});
}