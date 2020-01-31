import 'package:flutter/material.dart';
import 'package:stocksim/simulation.dart';

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
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {
                    print('Open Settings');
                  },
                )
              ],
              title: new Text("DSE Stock Simulator",
                  style: TextStyle(fontFamily: 'Lato Bold')),
              centerTitle: false,
              bottom: TabBar(
                isScrollable: false,
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
              onPressed: () {
                print('Clicked Plus');
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endFloat),
      ),
    );
  }
}

class LiveMarket extends StatelessWidget {
  final List<String> items = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemCount: 10,
        //u can use items.length...
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 2.0,
            child: new ListTile(
                onTap: () {
                  print('Open Dataset');
                },
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
                  decoration: new BoxDecoration(
                      border: new Border(
                          right: new BorderSide(
                              width: 1.0, color: Colors.pinkAccent))),
                  child: Icon(Icons.account_balance, color: Colors.pink),
                ),
                title: Text(
                  "CRDB",
                  style:
                      TextStyle(color: Colors.black, fontFamily: 'Lato Bold'),
                ),
                subtitle: Row(
                  children: <Widget>[
                    Icon(Icons.arrow_upward, color: Colors.green, size: 15.0),
                    Text(
                      " Opening Price: Tsh 785.00",
                      style: TextStyle(
                          color: Colors.green, fontFamily: 'Lato Medium'),
                    ),
                  ],
                ),
                trailing: Icon(Icons.keyboard_arrow_right, color: Colors.pink)),
          );
        },
      ),
    );
  }
}

class SimulatedTrading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
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
                style: TextStyle(fontSize: 25.0, fontFamily: 'Lato Bold'),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
                child: Text(
                    "Welcome To Stock Trading Simulation, Here You can Buy/Sell stock accordingly.",
                    style: TextStyle(
                        fontFamily: 'Lato Medium', color: Colors.black),
                    textAlign: TextAlign.center),
              ),
              SizedBox(height: 5.0),
              InkWell(
                child: ButtonTheme(
                  height: 40.0,
                  minWidth: 120.0,
                  child: RaisedButton(
                    onPressed: () {
                      print("Start Trading");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SimulationScreen()),
                      );
                    },
                    splashColor: Colors.pinkAccent,
                    color: Colors.pink,
                    child: Text(
                      "Start Trading",
                      style: TextStyle(
                          fontFamily: 'Lato Bold',
                          color: Colors.white,
                          fontSize: 15.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
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
