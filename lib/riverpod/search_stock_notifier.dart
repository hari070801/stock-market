import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_market_app/repository/api_functions.dart';
import 'package:stock_market_app/repository_models/search_stock_model.dart';

class SearchNotifier extends AsyncNotifier<List<SearchStockModel>> {
  @override
  Future<List<SearchStockModel>> build() async {
    return [];
  }

  Future<void> searchStocks(String query) async {
    if (query.isEmpty) {
      state = const AsyncData([]);
      return;
    }

    state = const AsyncLoading();

    try {
      List<SearchStockModel>? result = await getSearchStock(searchText: query);

      state = AsyncData(result!.toList());
    } catch (e) {
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }
}

// Provider
final searchProvider = AsyncNotifierProvider<SearchNotifier, List<SearchStockModel>>(() {
  return SearchNotifier();
});
