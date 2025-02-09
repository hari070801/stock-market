import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String jwt;
  User user;

  LoginModel({
    required this.jwt,
    required this.user,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        jwt: json["jwt"] ?? '',
        user: User.fromJson(json["user"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "jwt": jwt,
        "user": user.toJson(),
      };
}

class User {
  num id;
  String username;
  String email;
  String provider;
  bool confirmed;
  bool blocked;
  String createdAt;
  String updatedAt;
  String investorType;
  dynamic fcmToken;
  dynamic mobileNo;
  dynamic city;
  dynamic state;
  dynamic zipCode;
  dynamic resetPasswordOtp;
  dynamic deletedAt;
  dynamic externalProfilePictureUrl;
  dynamic addressLine1;
  dynamic addressLine2;
  String fullName;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.provider,
    required this.confirmed,
    required this.blocked,
    required this.createdAt,
    required this.updatedAt,
    required this.investorType,
    required this.fcmToken,
    required this.mobileNo,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.resetPasswordOtp,
    required this.deletedAt,
    required this.externalProfilePictureUrl,
    required this.addressLine1,
    required this.addressLine2,
    required this.fullName,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] ?? 0,
        username: json["username"] ?? '',
        email: json["email"] ?? '',
        provider: json["provider"] ?? "",
        confirmed: json["confirmed"] ?? false,
        blocked: json["blocked"] ?? false,
        createdAt: json["createdAt"] ?? '',
        updatedAt: json["updatedAt"] ?? '',
        investorType: json["investor_type"] ?? '',
        fcmToken: json["fcm_token"],
        mobileNo: json["mobile_no"],
        city: json["city"],
        state: json["state"],
        zipCode: json["zip_code"],
        resetPasswordOtp: json["reset_password_otp"],
        deletedAt: json["deleted_at"],
        externalProfilePictureUrl: json["external_profile_picture_url"],
        addressLine1: json["address_line_1"],
        addressLine2: json["address_line_2"],
        fullName: json["full_name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "provider": provider,
        "confirmed": confirmed,
        "blocked": blocked,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "investor_type": investorType,
        "fcm_token": fcmToken,
        "mobile_no": mobileNo,
        "city": city,
        "state": state,
        "zip_code": zipCode,
        "reset_password_otp": resetPasswordOtp,
        "deleted_at": deletedAt,
        "external_profile_picture_url": externalProfilePictureUrl,
        "address_line_1": addressLine1,
        "address_line_2": addressLine2,
        "full_name": fullName,
      };
}
