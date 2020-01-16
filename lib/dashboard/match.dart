import 'package:chelsea_news/match_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Match extends StatefulWidget {
  Match({Key key}) : super(key: key);

  @override
  _MatchState createState() => _MatchState();
}

class _MatchState extends State<Match> {
  
  @override
  Widget build(BuildContext context) {
    final matches = Provider.of<MatchRepository>(context).matchs;
    return ListView.builder(
      itemCount: matches.length,
      itemBuilder: (BuildContext context, int index) {
      return matchCard(matches[index]);
      },
    );
  }

  Widget matchCard(LeagueMatch match){
    return Card(
      elevation: 3.0,
      child: ListTile(
        leading: match.week != "null" ? Text(
          match.week,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Colors.grey[400]
          ),
        ) : Icon(
          Icons.adjust,
          size: 50,
        ),
        title: Text(
          match.enemy,
        ),
        subtitle: Text(
          match.time,
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.add_box,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}