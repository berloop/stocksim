import 'package:flutter/material.dart';
import 'package:stocksim/main.dart';
import 'package:stocksim/test.dart';
import 'models/sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(size: 150),
              SizedBox(height: 50),
              _signInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return InkWell(
      child: ButtonTheme(
        height: 40.0,
        minWidth: 120.0,
        child: RaisedButton(
          onPressed: () {
            //signing in with google..
            
            signInWithGoogle().whenComplete(() {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return MyHomePage();
                  },
                ),
              );
            });
          },
          splashColor: Colors.pinkAccent,
          color: Colors.pink,
          child: Text(
            "Google Sign-Up",
            style: TextStyle(
                fontFamily: 'Lato Bold', color: Colors.white, fontSize: 15.0),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
