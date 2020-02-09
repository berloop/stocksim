class Prices {
  String board;
  String change;
  String close;
  String company;
  String high;
  String lastDealPrice;
  String lastTradedQuantity;
  String low;
  String marketCap;
  String openingPrice;
  String timestamp;
  String volume;

  Prices(
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

  Prices.fromJson(Map<String, dynamic> json) {
    board = json['Board'];
    change = json['Change'];
    close = json['Close'];
    company = json['Company'];
    high = json['High'];
    lastDealPrice = json['LastDealPrice'];
    lastTradedQuantity = json['LastTradedQuantity'];
    low = json['Low'];
    marketCap = json['MarketCap'];
    openingPrice = json['OpeningPrice'];
    timestamp = json['Time'];
    volume = json['Volume'];
  }
}
