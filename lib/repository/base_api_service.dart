import 'dart:io';

abstract class BaseApiService {
  String baseUrl = "https://illuminate-production.up.railway.app/";
  String version = "api/";

  Future<dynamic> baseApiMethod({
    required String url,
    required Map<String, dynamic> query,
    required String method,
    required Map<String, String> headers,
    File? filePath,
    String? fileName,
  });
}
