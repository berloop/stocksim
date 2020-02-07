import 'package:flutter/material.dart';
import '../main.dart';

class StockPricesItem extends StatelessWidget {
  final List<LiveMarketPrices> stockPrice;
  StockPricesItem({Key key, this.stockPrice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stockPrice.length,
      itemBuilder: (context, index) {
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
              // cart_prod_qty!=null?cart_prod_qty:'Default Value'
              title: Text(
                "Company",
                style: TextStyle(color: Colors.black, fontFamily: 'Lato Bold'),
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
    );
  }
}
