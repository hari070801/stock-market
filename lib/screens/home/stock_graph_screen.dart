import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_market_app/resources/functions.dart';
import 'package:stock_market_app/resources/widgets.dart';
import 'package:stock_market_app/riverpod/stock_details_notifier.dart';
import 'package:stock_market_app/riverpod/stock_graph_notifier.dart';

class StockGraphScreen extends ConsumerStatefulWidget {
  final String imageUrl;
  final String stockSymbol;
  final String stockName;
  final String stockId;

  const StockGraphScreen({
    super.key,
    required this.imageUrl,
    required this.stockSymbol,
    required this.stockName,
    required this.stockId,
  });

  @override
  ConsumerState<StockGraphScreen> createState() => _StockGraphScreenState();
}

class _StockGraphScreenState extends ConsumerState<StockGraphScreen> {
  String selectedRange = "1M";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchGraphData();
    });
  }

  void fetchGraphData() {
    ref.read(stockGraphProvider.notifier).stockGraph(timeStamp: selectedRange, stockId: widget.stockId);
  }

  void changeRange(String range) {
    setState(() {
      selectedRange = range;
    });
    fetchGraphData();
  }

  @override
  Widget build(BuildContext context) {
    final stockDetailsState = ref.watch(stockDetailsProvider);
    final stockGraphState = ref.watch(stockGraphProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: stockDetailsState.when(
        loading: () => Center(child: Widgets().showLoader(color: Colors.white)),
        error: (err, _) {
          return Center(child: Text("Error: $err", style: const TextStyle(color: Colors.red)));
        },
        data: (stockDetails) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    borderRadius: BorderRadius.circular(50),
                    child: Widgets().networkImage(
                      url: widget.imageUrl,
                      height: 46,
                      width: 46,
                    ),
                  ),
                  SizedBox(width: getWidgetWidth(width: 10)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.stockSymbol,
                            style: TextStyle(
                              fontSize: getTextSize(fontSize: 26),
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            )),
                        Text(
                          widget.stockName,
                          style: TextStyle(
                            fontSize: getTextSize(fontSize: 20),
                            color: Colors.grey.shade400,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: getWidgetHeight(height: 20)),
              Text("₹${stockDetails!.price}",
                  style: TextStyle(
                    fontSize: getTextSize(fontSize: 40),
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  )),

              Text(
                stockDetails.changePercent >= 0 ? "+${stockDetails.changePercent.toStringAsFixed(2)}%" : "${stockDetails.changePercent.toStringAsFixed(2)}%",
                style: TextStyle(
                  fontSize: getTextSize(fontSize: 25),
                  fontWeight: FontWeight.w600,
                  color: stockDetails.changePercent >= 0 ? Colors.green : Colors.red,
                ),
              ),
              SizedBox(height: getWidgetHeight(height: 50)),

              // Graph
              stockGraphState.when(
                loading: () => AspectRatio(aspectRatio: 1.7, child: Center(child: Widgets().showLoader(color: Colors.white))),
                error: (err, _) => Center(child: Text("Error: $err", style: const TextStyle(color: Colors.red))),
                data: (stockPrices) {
                  return AspectRatio(
                    aspectRatio: 1.5,
                    child: stockPrices.isEmpty
                        ? Center(child: Text("No data available", style: TextStyle(color: Colors.white, fontSize: getTextSize(fontSize: 20))))
                        : LineChart(
                            LineChartData(
                                gridData: const FlGridData(show: true),
                                titlesData: const FlTitlesData(show: false),
                                borderData: FlBorderData(show: false),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: stockPrices.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.closePrice.toDouble())).toList(),
                                    isCurved: true,
                                    color: Colors.green,
                                    barWidth: 1.5,
                                    belowBarData: BarAreaData(
                                      show: true,
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.green.withOpacity(0.3),
                                          Colors.green.withOpacity(0.2),
                                          Colors.green.withOpacity(0.1),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                    dotData: FlDotData(
                                      show: true,
                                      checkToShowDot: (spot, _) => spot.y == stockPrices.map((e) => e.highPrice).reduce(max) || spot.y == stockPrices.map((e) => e.lowPrice).reduce(min),
                                      getDotPainter: (spot, _, __, ___) => FlDotCirclePainter(
                                        radius: 4,
                                        color: Colors.yellow,
                                        strokeWidth: 2,
                                        strokeColor: Colors.black,
                                      ),
                                    ),
                                    curveSmoothness: 0.9,
                                  ),
                                ],
                                extraLinesData: ExtraLinesData(horizontalLines: [
                                  HorizontalLine(
                                    y: stockPrices.map((e) => e.closePrice.toDouble()).reduce((a, b) => a > b ? a : b),
                                    color: Colors.white,
                                    strokeCap: StrokeCap.round,
                                    strokeWidth: 1,
                                    dashArray: [5, 5],
                                    label: HorizontalLineLabel(
                                      show: true,
                                      labelResolver: (line) => '₹${line.y.toStringAsFixed(2)} (High Price)',
                                      style: TextStyle(fontSize: getTextSize(fontSize: 12), fontWeight: FontWeight.bold, color: Colors.white),
                                      alignment: Alignment.topRight,
                                    ),
                                  ),
                                  HorizontalLine(
                                    y: stockPrices.map((e) => e.closePrice.toDouble()).reduce((a, b) => a < b ? a : b),
                                    color: Colors.white,
                                    strokeCap: StrokeCap.round,
                                    strokeWidth: 1,
                                    dashArray: [5, 5],
                                    label: HorizontalLineLabel(
                                      show: true,
                                      labelResolver: (line) => '₹${line.y.toStringAsFixed(2)} (Low Price)',
                                      style: TextStyle(fontSize: getTextSize(fontSize: 12), fontWeight: FontWeight.bold, color: Colors.white),
                                      alignment: Alignment.bottomRight,
                                    ),
                                  ),
                                ])),
                          ),
                  );
                },
              ),
              SizedBox(height: getWidgetHeight(height: 50)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: ["1W", "1M", "1Y"].asMap().entries.map((entry) {
                  final index = entry.key;
                  final range = entry.value;

                  return Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() => selectedRange = range);
                          changeRange(selectedRange);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: getWidgetHeight(height: 8), horizontal: getWidgetWidth(width: 16)),
                          decoration: BoxDecoration(
                            color: selectedRange == range ? Colors.white : Colors.black,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            range,
                            style: TextStyle(
                              color: selectedRange == range ? Colors.black : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      if (index < 2)
                        Container(
                          width: 2,
                          height: getWidgetHeight(height: 20),
                          color: Colors.grey.withOpacity(0.5),
                          margin: EdgeInsets.symmetric(horizontal: getWidgetWidth(width: 8)),
                        ),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
