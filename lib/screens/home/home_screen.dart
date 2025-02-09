import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_market_app/resources/app_colors.dart';
import 'package:stock_market_app/resources/functions.dart';
import 'package:stock_market_app/resources/widgets.dart';
import 'package:stock_market_app/riverpod/search_stock_notifier.dart';
import 'package:stock_market_app/riverpod/stock_details_notifier.dart';
import 'package:stock_market_app/screens/home/stock_graph_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Stock Market App',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.green,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: getWidgetHeight(height: 20),
          left: getWidgetWidth(width: 20),
          right: getWidgetWidth(width: 20),
        ),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: getTextSize(fontSize: 20),
                color: appColors.fontColor,
              ),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                hintText: 'Search for stocks',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: getTextSize(fontSize: 20),
                  color: appColors.darkGrey,
                ),
                prefixIconConstraints: BoxConstraints(
                  maxHeight: getWidgetHeight(height: 50),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: getWidgetWidth(width: 15)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                prefixIcon: Padding(
                    padding: EdgeInsets.only(
                      left: getWidgetWidth(width: 10),
                      right: getWidgetWidth(width: 11.52),
                    ),
                    child: Widgets().assetImage(
                      asset: 'assets/images/search-icon.png',
                      height: 15.15,
                      width: 15.01,
                    )),
              ),
              onChanged: (query) {
                ref.read(searchProvider.notifier).searchStocks(query);
              },
            ),
            SizedBox(height: getWidgetHeight(height: 20)),
            Expanded(
              child: searchState.when(
                  data: (stocks) {
                    if (searchController.text.isEmpty) {
                      return Center(
                        child: Text(
                          "Start searching for stocks to see results.",
                          style: TextStyle(
                            fontSize: getTextSize(fontSize: 20),
                            color: Colors.white70,
                          ),
                        ),
                      );
                    } else if (stocks.isEmpty && searchController.text.isNotEmpty) {
                      return Center(
                        child: Text(
                          "We couldn't find any stocks matching your search.",
                          style: TextStyle(
                            fontSize: getTextSize(fontSize: 20),
                            color: Colors.white70,
                          ),
                        ),
                      );
                    } else {
                      return ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(height: getWidgetHeight(height: 20));
                        },
                        itemCount: stocks.length,
                        itemBuilder: (context, index) {
                          final stock = stocks[index];
                          return InkWell(
                            onTap: () async {
                              await ref.read(stockDetailsProvider.notifier).stockDetails(stockId: stock.id.toString());
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return StockGraphScreen(
                                    imageUrl: stock.image.url,
                                    stockName: stock.name,
                                    stockSymbol: stock.symbol,
                                    stockId: stock.id.toString(),
                                  );
                                },
                              ));
                            },
                            child: Row(
                              children: [
                                ClipRRect(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  borderRadius: BorderRadius.circular(50),
                                  child: Widgets().networkImage(
                                    url: stock.image.url,
                                    height: 46,
                                    width: 46,
                                  ),
                                ),
                                SizedBox(width: getWidgetWidth(width: 16)),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        stock.symbol,
                                        style: TextStyle(
                                          fontSize: getTextSize(fontSize: 20),
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: getWidgetHeight(height: 5)),
                                      Text(
                                        stock.name,
                                        style: TextStyle(
                                          fontSize: getTextSize(fontSize: 18),
                                          color: Colors.white70,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                  loading: () => Widgets().showLoader(color: Colors.white), // Loader
                  error: (error, stacktrace) {
                    print("stacktrace : $stacktrace");
                    return Center(child: Text("Error: $error"));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
