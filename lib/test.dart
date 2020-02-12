import 'package:flutter/material.dart';

import 'login.dart';
import 'models/sign_in.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          email,
          style: TextStyle(
            fontFamily: 'Lato Bold',
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(child: Text("Logged In")),
          ),
          Center(
            child: InkWell(
              child: ButtonTheme(
                height: 40.0,
                minWidth: 120.0,
                child: RaisedButton(
                  onPressed: () {
                    Future.delayed(
                      Duration(seconds: 3),
                      () {
                        signOutGoogle();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) {
                          return LoginPage();
                        }), ModalRoute.withName('/'));
                      },
                    );
                  },
                  splashColor: Colors.pinkAccent,
                  color: Colors.pink,
                  child: Text(
                    "Sign Out",
                    style: TextStyle(
                        fontFamily: 'Lato Bold',
                        color: Colors.white,
                        fontSize: 15.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          Image.network(imageUrl),
          Text(name)
        ],
      ),
    );
  }
}
