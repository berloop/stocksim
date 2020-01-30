import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: DefaultTabController(
        length: 4,
        child: new Scaffold(
          appBar: new AppBar(
            title: new Text("DSE Stock Simulator",
                style: TextStyle(fontFamily: 'Lato Bold')),
            centerTitle: false,
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: "Live Market", icon: Icon(Icons.account_balance)),
                Tab(text: "Simulation", icon: Icon(Icons.linear_scale)),
                Tab(text: "News", icon: Icon(Icons.chrome_reader_mode)),
                Tab(text: "Portfolio", icon: Icon(Icons.person_pin)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              LiveMarket(),
              SimulatedTrading(),
              NewsFeeds(),
              Portfolio()
             
            ],
          ),
          floatingActionButton: FloatingActionButton(
  child: Icon(Icons.add),
  onPressed: () { print('Clicked Plus'); },
  
  ),
  floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

        ),
      ),
    );
  }
}

class LiveMarket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        elevation: 15.0,
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.account_balance, size: 128.0, color: Colors.pink),
              Text(
                "Real-Time Market Data",
                style: TextStyle(fontSize: 20, fontFamily: 'Lato Bold'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SimulatedTrading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        elevation: 15.0,
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.blur_linear, size: 128.0, color: Colors.pink),
              Text(
                "Trading Simulation",
                style: TextStyle(fontSize: 20, fontFamily: 'Lato Bold'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class NewsFeeds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        elevation: 15.0,
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.chrome_reader_mode, size: 128.0, color: Colors.pink),
              Text(
                "News Feeds",
                style: TextStyle(fontSize: 20, fontFamily: 'Lato Bold'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  }


class Portfolio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        elevation: 15.0,
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.person_pin, size: 128.0, color: Colors.pink),
              Text(
                "Portfolio",
                style: TextStyle(fontSize: 20, fontFamily: 'Lato Bold'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  }
