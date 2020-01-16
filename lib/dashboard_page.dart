import 'package:chelsea_news/dashboard/saved.dart';
import 'package:chelsea_news/dashboard/match.dart';
import 'package:chelsea_news/dashboard/standings.dart';
import 'package:chelsea_news/destination.dart';
import 'package:chelsea_news/match_repository.dart';
import 'package:chelsea_news/user_repository.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  final FirebaseUser user;
  DashboardPage({Key key, @required this.user}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _key = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  int load;
  var connectivityResult;
  List<Widget> _pages = [
    Match(),
    Standings(),
    Saved(),
  ];

  @override
  void initState() {
    super.initState();
    checkConnectivity();
    load = 0;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    final matchRepo = Provider.of<MatchRepository>(context);
    if(connectivityResult != ConnectivityResult.none && load == 0){
      matchRepo.getStandings();
      matchRepo.getMatches();
      load++;
    }

    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: allDestination[_currentIndex].color,
        title: Text("Chelsea News"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              user.signOut();
            },
          )
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: allDestination.map((Destination destination) {
          return BottomNavigationBarItem(
            icon: Icon(destination.icon),
            backgroundColor: destination.color,
            title: Text(destination.title)
          );
        }).toList(),
      ),
    );
  }

  void checkConnectivity() async {
    connectivityResult = await (Connectivity().checkConnectivity());
  }

  @override
  void dispose() {
    super.dispose();
  }
}