import 'package:chelsea_news/match_repository.dart';
import 'package:chelsea_news/phone_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Standings extends StatefulWidget {
  Standings({Key key}) : super(key: key);

  @override
  _StandingsState createState() => _StandingsState();
}

class _StandingsState extends State<Standings> {
  List<DataRow> _tableRow = [];

  @override
  Widget build(BuildContext context) {
    final matchRepo = Provider.of<MatchRepository>(context);
    for (var match in matchRepo.standings) {
      _tableRow.add(DataRow(
        cells: [
          DataCell(
            Text(match.name)
          ),
          DataCell(
            Text(match.win)
          ),
          DataCell(
            Text(match.draw)
          ),
          DataCell(
            Text(match.lose)
          ),
          DataCell(
            Text(match.goalDifference)
          ),
          DataCell(
            Text(match.point)
          )
        ],
      ));
    }

    return ListView(
      children: [
        DataTable(
          columnSpacing: width*0.02,
          columns: [
            DataColumn(
              label: Text("Team")
            ),
            DataColumn(
              label: Text("Win")
            ),
            DataColumn(
              label: Text("Draw")
            ),
            DataColumn(
              label: Text("Lose")
            ),
            DataColumn(
              label: Text("GD")
            ),
            DataColumn(
              label: Text("Point")
            ),
          ],
          rows: _tableRow,
        ),
      ]
    );
  }
}