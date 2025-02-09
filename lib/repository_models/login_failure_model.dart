import 'dart:convert';

LoginFailureModel loginFailureModelFromJson(String str) => LoginFailureModel.fromJson(json.decode(str));

String loginFailureModelToJson(LoginFailureModel data) => json.encode(data.toJson());

class LoginFailureModel {
  dynamic data;
  Error error;

  LoginFailureModel({
    required this.data,
    required this.error,
  });

  factory LoginFailureModel.fromJson(Map<String, dynamic> json) => LoginFailureModel(
        data: json["data"],
        error: Error.fromJson(json["error"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "error": error.toJson(),
      };
}

class Error {
  int status;
  String name;
  String message;
  Details details;

  Error({
    required this.status,
    required this.name,
    required this.message,
    required this.details,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        status: json["status"] ?? 0,
        name: json["name"] ?? '',
        message: json["message"] ?? '',
        details: Details.fromJson(json["details"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "name": name,
        "message": message,
        "details": details.toJson(),
      };
}

class Details {
  Details();

  factory Details.fromJson(Map<String, dynamic> json) => Details();

  Map<String, dynamic> toJson() => {};
}
