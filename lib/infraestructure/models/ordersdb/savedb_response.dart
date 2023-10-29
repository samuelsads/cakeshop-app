import 'dart:convert';

SavedbResponse savedbResponseFromJson(String str) =>
    SavedbResponse.fromJson(json.decode(str));

String savedbResponseToJson(SavedbResponse data) => json.encode(data.toJson());

class SavedbResponse {
  final bool success;
  final String msg;
  final String? id;

  SavedbResponse({required this.success, required this.msg, this.id});

  factory SavedbResponse.fromJson(Map<String, dynamic> json) => SavedbResponse(
      success: json["success"], msg: json["msg"], id: json["id"]);

  Map<String, dynamic> toJson() => {"success": success, "msg": msg, "id": id};
}
