import 'dart:convert';

List<StockGraphModel> stockGraphModelFromJson(String str) => List<StockGraphModel>.from(json.decode(str).map((x) => StockGraphModel.fromJson(x)));

String stockGraphModelToJson(List<StockGraphModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StockGraphModel {
  num closePrice;
  num highPrice;
  num lowPrice;
  num tradeCount;
  num openPrice;
  String timestamp;
  num volume;
  num vwap;

  StockGraphModel({
    required this.closePrice,
    required this.highPrice,
    required this.lowPrice,
    required this.tradeCount,
    required this.openPrice,
    required this.timestamp,
    required this.volume,
    required this.vwap,
  });

  factory StockGraphModel.fromJson(Map<String, dynamic> json) => StockGraphModel(
        closePrice: json["ClosePrice"] ?? 0,
        highPrice: json["HighPrice"] ?? 0,
        lowPrice: json["LowPrice"] ?? 0,
        tradeCount: json["TradeCount"] ?? 0,
        openPrice: json["OpenPrice"] ?? 0,
        timestamp: json["Timestamp"] ?? '',
        volume: json["Volume"] ?? 0,
        vwap: json["VWAP"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "ClosePrice": closePrice,
        "HighPrice": highPrice,
        "LowPrice": lowPrice,
        "TradeCount": tradeCount,
        "OpenPrice": openPrice,
        "Timestamp": timestamp,
        "Volume": volume,
        "VWAP": vwap,
      };
}
