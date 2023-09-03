import 'dart:convert';

TotalOrderDbResponse totalOrderDbResponseFromJson(String str) =>
    TotalOrderDbResponse.fromJson(json.decode(str));

String totalOrderDbResponseToJson(TotalOrderDbResponse data) =>
    json.encode(data.toJson());

class TotalOrderDbResponse {
  final bool success;
  final String? msg;
  final int today;
  final int tomorrow;
  final int total;

  TotalOrderDbResponse({
    required this.success,
    this.msg,
    required this.today,
    required this.tomorrow,
    required this.total,
  });

  factory TotalOrderDbResponse.fromJson(Map<String, dynamic> json) =>
      TotalOrderDbResponse(
        success: json["success"],
        msg: json["msg"],
        today: json["today"],
        tomorrow: json["tomorrow"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "msg": msg,
        "today": today,
        "tomorrow": tomorrow,
        "total": total,
      };
}
