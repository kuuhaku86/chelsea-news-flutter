import 'package:chelsea_news/phone_size.dart';
import 'package:chelsea_news/text_style.dart';
import 'package:chelsea_news/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email;
  TextEditingController _password;
  final _key = GlobalKey<ScaffoldState>();
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController(text: '');
    _password = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    return Scaffold(
      key: _key,
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              padding:EdgeInsets.only(top: 20, bottom: 10),
              height: (height*0.4),
              width: width,
              child: Image.network('https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fen%2Fthumb%2Fc%2Fcc%2FChelsea_FC.svg%2F200px-Chelsea_FC.svg.png&f=1&nofb=1'),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(175)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: _email,
                      validator: (value) => (value.isEmpty) ? "Please Enter Your Email" : null,
                      style: style,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: "Email",
                        border: OutlineInputBorder()
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: _password,
                      validator: (value) => (value.isEmpty) ? "Please Enter Your Password" : null,
                      style: style,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: "Password",
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible ? Icons.visibility_off : Icons.visibility,
                            semanticLabel: _passwordVisible ? 'hide password' : 'show password',
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                obscureText: !_passwordVisible,
              ),
            ),
            user.status == Status.Authenticating
              ? Center(child: CircularProgressIndicator(),)
              : Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: height*0.01),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.blue[300],
                      child: MaterialButton(
                        minWidth: 0.75*width,
                        onPressed: () async {
                          if(!await user.signIn(_email.text, _password.text))
                            _key.currentState.showSnackBar(SnackBar(content: Text('Something Wrong'),));
                        },
                        child: Text(
                          "Sign In",
                          style: style.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: height*0.01),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.blue[200],
                      child: MaterialButton(
                        minWidth: 0.75*width,
                        onPressed: () async {
                          if(!await user.signUp(_email.text, _password.text))
                            _key.currentState.showSnackBar(SnackBar(content: Text('Something Wrong'),));
                        },
                        child: Text(
                          "Sign Up",
                          style: style.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )
                        ),
                      ),
                    ),
                  ),
                ],
              )
          ],
        ),
      )
    );
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
}