import 'package:chelsea_news/dateutil.dart';
import 'package:chelsea_news/match_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Saved extends StatefulWidget {
  Saved({Key key}) : super(key: key);

  @override
  _SavedState createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  var matches;
  @override
  Widget build(BuildContext context) {
    matches = Provider.of<MatchRepository>(context);
    return ListView.builder(
      itemCount: matches.privateMatchs.length,
      itemBuilder: (BuildContext context, int index) {
      return matchCard(matches.privateMatchs[index]);
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
          size: 45,
        ),
        title: Text(
          match.enemy,
        ),
        subtitle: Text(
          DateUtil().formattedDate(DateTime.parse(match.time).toLocal())
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.cancel,
            color: Colors.black,
          ),
          onPressed: () {
            matches.removeMatch(match);
          },
        ),
      ),
    );
  }
}