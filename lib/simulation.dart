import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SimulationScreen extends StatefulWidget {
  @override
  _SimulationScreenState createState() => _SimulationScreenState();
}

class _SimulationScreenState extends State<SimulationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Trading Simulation",
          style: TextStyle(
            fontFamily: 'Lato Bold',
          ),
        ),
        centerTitle: true,
      ),
      body: CardSwiper(),
    );
  }
}

// class CustomSwiper extends StatelessWidget {
//   final List<String> tradingDatasets = [
//     '1',
//     '2',
//     '3',
//     '4',
//     '5',
//     '6',
//     '7',
//     '8',
//     '9'
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: MediaQuery.of(context).size.height * 0.8,
//         padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
//         child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: tradingDatasets.length,
//             itemBuilder: (context, index) {
//               return Container(
//                 width: MediaQuery.of(context).size.width * .9,
//                 child: Card(
//                   elevation: 2.0,
//                   color: Colors.white,
//                   child: Container(
//                     child: Center(
//                         child: Text(
//                       tradingDatasets[index].toString(),
//                       style: TextStyle(color: Colors.white, fontSize: 36.0),
//                     )),
//                   ),
//                 ),
//               );
//             }));
//   }
// }

class CardSwiper extends StatelessWidget {
  final List<String> tradingDatasets = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9'
  ];
  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(top:5.0,bottom: 35.0),
          child: Container(
             height: MediaQuery.of(context).size.height,
            child: new Card(
              elevation: 15.0,
              color: Colors.white,
              child: Container(
                child: Center(
                    child: Text(
                  tradingDatasets[index].toString(),
                  style: TextStyle(color: Colors.pink, fontSize: 36.0),
                ),
                ),
              ),
            ),
          ),
        );
      },
      itemCount: tradingDatasets.length,
      pagination: new SwiperPagination(),
      loop:true,
      viewportFraction: 0.9,
      scale:0.8,
      itemWidth:200.0,
    );
  }
}
