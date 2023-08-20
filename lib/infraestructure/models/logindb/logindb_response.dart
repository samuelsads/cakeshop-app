import 'dart:convert';

import 'package:cakeshopapp/infraestructure/models/userdb/user_userdb.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  final bool success;
  final String? msg;
  final UserUserDB? user;
  final String? token;

  LoginResponse({
    required this.success,
    this.msg,
    this.user,
    this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        success: json["success"],
        msg: json["msg"],
        user: UserUserDB.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "msg": msg,
        "user": user == null ? null : user!.toJson(),
        "token": token,
      };
}
