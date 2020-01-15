import 'package:chelsea_news/dashboard_page.dart';
import 'package:chelsea_news/login_page.dart';
import 'package:chelsea_news/match_repository.dart';
import 'package:chelsea_news/phone_size.dart';
import 'package:chelsea_news/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserRepository>(
          create: (_) => new UserRepository.instance(),
        ),
        ChangeNotifierProvider<MatchRepository>(
          create: (_) => MatchRepository(),
        ),
      ],
      child: MaterialApp(
        title: 'Chelsea News',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SplashScreen(
      seconds: 3,
      image: Image.network('https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fen%2Fthumb%2Fc%2Fcc%2FChelsea_FC.svg%2F200px-Chelsea_FC.svg.png&f=1&nofb=1'),
      navigateAfterSeconds: Consumer(
        builder: (context, UserRepository user, _) {
          switch(user.status) {
            case Status.Unauthenticated:
            case Status.Authenticating:
              return LoginPage();
            case Status.Authenticated:
              return DashboardPage(user: user.user);
          }
        },
      ),
      photoSize: width*0.5,
    );
  }
}