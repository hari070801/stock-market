import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_market_app/repository/api_functions.dart';
import 'package:stock_market_app/repository_models/stock_graph_model.dart';

class StockGraphNotifier extends AsyncNotifier<List<StockGraphModel>> {
  @override
  Future<List<StockGraphModel>> build() async {
    return [];
  }

  Future<void> stockGraph({required String stockId, required String timeStamp}) async {
    if (timeStamp.isEmpty) {
      state = const AsyncData([]);
      return;
    }

    state = const AsyncLoading();

    try {
      List<StockGraphModel>? result = await getStockGraph(stockId: stockId, timeStamp: timeStamp);

      state = AsyncData(result!.toList());
    } catch (e) {
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }
}

// Provider
final stockGraphProvider = AsyncNotifierProvider<StockGraphNotifier, List<StockGraphModel>>(() {
  return StockGraphNotifier();
});
