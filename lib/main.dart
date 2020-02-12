import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stocksim/models/news_item.dart';
import 'package:stocksim/simulation.dart';
import 'package:http/http.dart' as http;
import 'login.dart';
import 'models/news.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'models/prices.dart';

//making network request..
Future<List<LiveMarketPrices>> fetchLiveMarketPrices(http.Client client) async {
  final response = await client.get('https://api.myjson.com/bins/u014y');

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    // Use the compute function to run parseMarketPrices in a separate isolate.
    return compute(parseLiveMarketPrices, response.body);
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load Datasets');
  }
}

// A function that converts a response body into a List<Photo>.
List<LiveMarketPrices> parseLiveMarketPrices(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed
      .map<LiveMarketPrices>((json) => LiveMarketPrices.fromJson(json))
      .toList();
}

class LiveMarketPrices {
  final String board;
  final String change;
  final String close;
  final String company;
  final String high;
  final String lastDealPrice;
  final String lastTradedQuantity;
  final String low;
  final String marketCap;
  final String openingPrice;
  final String timestamp;
  final String volume;

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
      board: json['Board'] as String,
      change: json['Change'] as String,
      close: json['Close'] as String,
      company: json['Company'] as String,
      high: json['High'] as String,
      lastDealPrice: json['LastDealPrice'] as String,
      lastTradedQuantity: json['LastTradedQuantity'] as String,
      low: json['Low'] as String,
      marketCap: json['MarketCap'] as String,
      openingPrice: json['OpeningPrice'] as String,
      timestamp: json['Time'] as String,
      volume: json['Volume'] as String,
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
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: TabsView(),
    );
  }

  // @override
  // // void initState() {
  // //   super.initState();
  // //   Future.delayed(
  // //     Duration(seconds: 1),
  // //     () {
  // //       //then navigate to login screen
  // //       Navigator.push(
  // //         context,
  // //         MaterialPageRoute(
  // //           builder: (context) => LoginPage(),
  // //         ),
  // //       );
  // //     },
  // //   );
  // // }
}

class LiveMarket extends StatefulWidget {
  @override
  _LiveMarketState createState() => _LiveMarketState();
}

class _LiveMarketState extends State<LiveMarket> {
  List<Prices> _prices = List<Prices>();

  Future<List<Prices>> fetchNotes() async {
    var url = "https://abdulmtoro3.netlify.com/data/prices.json";
    var response = await http.get(url);

    var prices = List<Prices>();

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        prices.add(Prices.fromJson(noteJson));
      }
    }
    return prices;
  }

  void connectivityTest() async {
    try {
      //ping to google..
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        this.fetchNotes();
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
    fetchNotes().then((value) {
      setState(() {
        _prices.addAll(value);
      });
    });
    super.initState();
    this.connectivityTest();
  }

  String getDouble(String price) {
    //my magic function..
    var doubleValue = double.parse(price);
    var fixedValue = doubleValue.toStringAsFixed(2);
    return fixedValue.toString();
  }

  String getBillion(String cap) {
    var doubleValue = double.parse(cap);
    var billion = doubleValue / 100000000;
    var fixedBillion = billion.toStringAsFixed(2);
    if (billion > 1000) {
      var finalTrillion = billion / 1000;
      var fixedTrillion = finalTrillion.toStringAsFixed(2);

      return fixedTrillion.toString() + "Tr";
    }
    return fixedBillion.toString() + "Bn";
  }

  @override
  Widget build(BuildContext context) {
    return _prices.isEmpty
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: _prices.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5.0,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text(
                                  _prices[index].company,
                                  style: TextStyle(
                                      fontFamily: 'Lato Bold',
                                      fontSize: 18.0,
                                      color: Colors.pink),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.add,
                                  size: 15.0,
                                ),
                                Text(
                                  getBillion(_prices[index].marketCap),
                                  style: TextStyle(
                                      fontFamily: 'Lato Bold', fontSize: 15.0),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text(
                                  "Tsh " +
                                      getDouble(_prices[index].openingPrice),
                                  style: TextStyle(
                                      fontFamily: 'Lato Bold',
                                      fontSize: 15.0,
                                      color: Colors.black),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.arrow_upward,
                                  color: Colors.green,
                                  size: 18.0,
                                ),
                                Text(getDouble(_prices[index].change) + "%",
                                    style: TextStyle(
                                        fontFamily: 'Lato Bold',
                                        fontSize: 14.0))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
            });
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
        "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=801889422ea1495ba303cce1978429f9");
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
    return _newslist.isEmpty
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return NewsListItem(_newslist[index]);
            },
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

// DateFormat dateFormat = DateFormat("MMMM dd, yyyy");
// dateFormat.format(DateTime.now()),

class TabsView extends StatefulWidget {
  @override
  _TabsViewState createState() => _TabsViewState();
}

class _TabsViewState extends State<TabsView> {
  final appname = "Stock Trading Simulator";
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
            title: new Text(appname, style: TextStyle(fontFamily: 'Lato Bold')),
            centerTitle: false,
            bottom: TabBar(
              isScrollable: false,
              tabs: [
                Tab(text: "Overview", icon: Icon(Icons.account_balance)),
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
            child: Icon(Icons.blur_linear),
            onPressed: () {
              print('Clicked Plus');
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat),
    );
  }
}
