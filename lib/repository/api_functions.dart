import 'dart:async';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_market_app/repository/api_end_points.dart';
import 'package:stock_market_app/repository/base_api_service.dart';
import 'package:stock_market_app/repository/network_api_service.dart';
import 'package:stock_market_app/repository_models/login_failure_model.dart';
import 'package:stock_market_app/repository_models/login_model.dart';
import 'package:stock_market_app/repository_models/search_stock_model.dart';
import 'package:stock_market_app/repository_models/stock_details_model.dart';
import 'package:stock_market_app/repository_models/stock_graph_model.dart';
import 'package:stock_market_app/riverpod/login_notifier.dart';

final BaseApiService _apiService = NetworkApiService();

Future<dynamic> loginApi({required String email, required String password}) async {
  var parameter = {
    "identifier": email,
    "password": password,
  };
  log("login parameter : $parameter");

  try {
    var response = await _apiService.baseApiMethod(
      url: ApiEndPoints().login,
      query: parameter,
      method: 'post',
      headers: {},
    );

    print("response : $response");

    if (response != null) {
      if (statusCode == 200) {
        print("login success");
        return LoginModel.fromJson(response);
      } else if (statusCode == 400) {
        print("login failure");
        return LoginFailureModel.fromJson(response);
      }
    } else {
      log("login value is null");
    }
  } catch (e, stacktrace) {
    log("Error during login api: $e");
    log("Error during login api: $stacktrace");
  }

  return null;
}

Future<List<SearchStockModel>?> getSearchStock({required String searchText}) async {
  try {
    final prefs = await SharedPreferences.getInstance();

    var loginToken = prefs.getString('loginToken');

    print("loginToken : $loginToken");

    var response = await _apiService.baseApiMethod(
      url: '${ApiEndPoints().searchStock}$searchText',
      query: {},
      method: 'get',
      headers: {'Authorization': 'Bearer $loginToken'},
    );

    print("response : $response");

    if (response != null && response is List) {
      return response.map((json) => SearchStockModel.fromJson(json)).toList();
    } else {
      log("Search response is null or not a list");
    }
  } catch (e, stacktrace) {
    log("Error during search stock api: $e");
    log("Error during search stock api: $stacktrace");
  }

  return null;
}

Future<List<StockGraphModel>?> getStockGraph({required String stockId, required String timeStamp}) async {
  try {
    final prefs = await SharedPreferences.getInstance();

    var loginToken = prefs.getString('loginToken');

    print("loginToken : $loginToken");

    var response = await _apiService.baseApiMethod(
      url: 'stocks/$stockId/price-graph?range=$timeStamp',
      query: {},
      method: 'get',
      headers: {'Authorization': 'Bearer $loginToken'},
    );

    print("response : $response");

    if (response != null && response is List) {
      return response.map((json) => StockGraphModel.fromJson(json)).toList();
    } else {
      log("stock graph response is null or not a list");
    }
  } catch (e, stacktrace) {
    log("Error during stock graph api: $e");
    log("Error during stock graph: $stacktrace");
  }

  return null;
}

Future<StockDetailsModel?> getStockDetails({required String stockId}) async {
  try {
    final prefs = await SharedPreferences.getInstance();

    var loginToken = prefs.getString('loginToken');

    print("loginToken : $loginToken");

    var response = await _apiService.baseApiMethod(
      url: 'stocks/$stockId',
      query: {},
      method: 'get',
      headers: {'Authorization': 'Bearer $loginToken'},
    );

    print("response : $response");

    if (response != null) {
      return StockDetailsModel.fromJson(response);
    } else {
      log("stock details response is null or not a list");
    }
  } catch (e, stacktrace) {
    log("Error during stock details api: $e");
    log("Error during stock details api: $stacktrace");
  }

  return null;
}
