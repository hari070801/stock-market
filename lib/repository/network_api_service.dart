import 'dart:io';

import 'package:dio/dio.dart';
import 'package:stock_market_app/repository/app_exception.dart';
import 'package:stock_market_app/repository/base_api_service.dart';
import 'package:stock_market_app/riverpod/login_notifier.dart';

Dio dio = Dio(
  BaseOptions(
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
    sendTimeout: const Duration(seconds: 60),
  ),
);

class NetworkApiService extends BaseApiService {
  @override
  Future<dynamic> baseApiMethod({
    required String url,
    required Map<String, dynamic> query,
    required String method,
    required Map<String, String> headers,
    File? filePath,
    String? fileName,
  }) async {
    dynamic responseJson;
    try {
      String uri = baseUrl + version + url;
      print("uri : $uri");

      Map<String, dynamic> body = query;
      switch (method) {
        case "get":
          {
            Response response = await dio.get(uri, options: Options(headers: headers), data: body);
            responseJson = returnDioResponse(response);
          }
        case "post":
          {
            Response response = await dio.post(uri,
                options: Options(
                  headers: headers,
                  validateStatus: (status) => true,
                ),
                data: body);
            responseJson = returnDioResponse(response);
            print("responseJson : $responseJson");
          }
        case "pdf":
          {
            Response response = await dio.post(uri,
                options: Options(
                  responseType: ResponseType.bytes,
                  headers: headers,
                ),
                data: body);
            responseJson = returnDioResponse(response);
          }
        case "put":
          {
            Response response = await dio.put(uri, options: Options(headers: headers), data: body);
            responseJson = returnDioResponse(response);
          }
        case "patch":
          {
            Response response = await dio.patch(uri, options: Options(headers: headers), data: body);
            responseJson = returnDioResponse(response);
          }
        case "delete":
          {
            Response response = await dio.delete(uri, options: Options(headers: headers), data: body);
            responseJson = returnDioResponse(response);
          }
        case "upload":
          {
            print("uploading .....");
            var formData = FormData.fromMap(
              {
                'avatar': await MultipartFile.fromFile(filePath!.path, filename: 'png'),
              },
            );
            print("formData $formData");
            Response response = await dio.post(uri, options: Options(headers: headers), data: formData);
            print("response $response");
            responseJson = returnDioResponse(response);
            break;
          }
        default:
          {
            Response response = await dio.get(uri, options: Options(headers: headers), data: body);
            responseJson = returnDioResponse(response);
          }
      }
    } catch (e) {
      print("e error : $e");
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Network not available, Please check it");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
    return responseJson;
  }

  dynamic returnDioResponse(Response response) async {
    print("response.statusCode : ${response.statusCode}");

    statusCode = response.statusCode!;

    switch (response.statusCode) {
      case 200:
        dynamic responseJson = response.data;
        return responseJson;
      case 201:
        dynamic responseJson = response.data;
        return responseJson;
      case 400:
        dynamic responseJson = response.data;
        return responseJson;
      case 401:
      case 403:
      case 404:
      case 500:
      default:
        throw FetchDataException('Error occurred while communication with server with status code : ${response.statusCode}');
    }
  }
}
