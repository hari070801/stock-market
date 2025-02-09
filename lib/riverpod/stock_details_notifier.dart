import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_market_app/repository/api_functions.dart';
import 'package:stock_market_app/repository_models/stock_details_model.dart';

class StockDetailsNotifier extends AsyncNotifier<StockDetailsModel?> {
  @override
  Future<StockDetailsModel?> build() async {
    return null;
  }

  Future<void> stockDetails({required String stockId}) async {
    if (stockId.isEmpty) {
      state = const AsyncData(null);
      return;
    }

    state = const AsyncLoading();

    try {
      StockDetailsModel? result = await getStockDetails(stockId: stockId);

      state = AsyncData(result);
    } catch (e) {
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }
}

// Provider
final stockDetailsProvider = AsyncNotifierProvider<StockDetailsNotifier, StockDetailsModel?>(
  () => StockDetailsNotifier(),
);
