import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stocksim/models/news_item.dart';
import 'package:stocksim/simulation.dart';
import 'package:http/http.dart' as http;
import 'models/news.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';

//making network request..
Future<List<LiveMarketPrices>> fetchPhotos(http.Client client) async {
  final response = await client.get('https://api.myjson.com/bins/6s9va');

  // Use the compute function to run parseMarketPrices in a separate isolate.
  return compute(parseMarketPrices, response.body);
}

// A function that converts a response body into a List<Photo>.
List<LiveMarketPrices> parseMarketPrices(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed
      .map<LiveMarketPrices>((json) => LiveMarketPrices.fromJson(json))
      .toList();
}

class LiveMarketPrices {
  final String board;
  final double change;
  final double close;
  final String company;
  final double high;
  final double lastDealPrice;
  final int lastTradedQuantity;
  final double low;
  final double marketCap;
  final double openingPrice;
  final String timestamp;
  final int volume;

  LiveMarketPrices(
      {this.board,
      this.change,
      this.close,
      this.company,
      this.high,
      this.lastDealPrice,
      this.lastTradedQuantity,
      this.low,
      this.marketCap,
      this.openingPrice,
      this.timestamp,
      this.volume});

  factory LiveMarketPrices.fromJson(Map<String, dynamic> json) {
    return LiveMarketPrices(
      board: json['board'] as String,
      change: json['change'] as double,
      close: json['close'] as double,
      company: json['company'] as String,
      high: json['high'] as double,
      lastDealPrice: json['lastDealPrice'] as double,
      lastTradedQuantity: json['lastTradedQuantity'] as int,
      low: json['low'] as double,
      marketCap: json['marketCap'] as double,
      openingPrice: json['openingPrice'] as double,
      timestamp: json['timestamp'] as String,
      volume: json['volume'] as int,
    );
  }
}

void main() {
  //fixing async issue on main()..
  WidgetsFlutterBinding.ensureInitialized();
  //locking device orientation..
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

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
  final String appname = "Stock Trading Simulator";
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
              title:
                  new Text(appname, style: TextStyle(fontFamily: 'Lato Bold')),
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

class NewsFeeds extends StatefulWidget {
  @override
  _NewsFeedsState createState() => _NewsFeedsState();
}

class _NewsFeedsState extends State<NewsFeeds> {
  List<NewsArticle> _newslist = new List();

  void getData() async {
    http.Response response = await http.get(
        "https://newsapi.org/v2/top-headlines?category=business&apiKey=801889422ea1495ba303cce1978429f9");
    setState(() {
      _newslist = News.fromJson(json.decode(response.body)).articles;
    });
  }

  void connectivityTest() async {
    try {
      //ping to google..
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        this.getData();
      }
    } on SocketException catch (_) {
      final snackBar = SnackBar(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.error, size: 25.0, color: Colors.pink),
            SizedBox(width: 3.0),
            Text('It seems that you\'re Offline!',
                style: TextStyle(
                  color: Colors.pink,
                )),
          ],
        ),
      );
// Find the Scaffold in the widget tree and use it to show a SnackBar.
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    super.initState();
    this.connectivityTest();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: new ListView.builder(
          itemCount: _newslist.length,
          itemBuilder: (context, int index) {
            return NewsListItem(_newslist[index]);
          }),
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
