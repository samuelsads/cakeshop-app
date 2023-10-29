import 'dart:convert';

ClientdbSearchResponse clientdbSearchResponseFromJson(String str) =>
    ClientdbSearchResponse.fromJson(json.decode(str));

String clientdbSearchResponseToJson(ClientdbSearchResponse data) =>
    json.encode(data.toJson());

class ClientdbSearchResponse {
  final bool success;
  final List<Datum> data;

  ClientdbSearchResponse({
    required this.success,
    required this.data,
  });

  factory ClientdbSearchResponse.fromJson(Map<String, dynamic> json) =>
      ClientdbSearchResponse(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  final String name;
  final String fatherSurname;
  final String? motherSurname;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String uid;

  Datum({
    required this.name,
    required this.fatherSurname,
    this.motherSurname,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.uid,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
        fatherSurname: json["father_surname"],
        motherSurname: json["mother_surname"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "father_surname": fatherSurname,
        "mother_surname": motherSurname,
        "user_id": userId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "uid": uid,
      };
}
