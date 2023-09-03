import 'dart:convert';
import 'dart:ffi';

OrdersDbResponse ordersDbResponseFromJson(String str) =>
    OrdersDbResponse.fromJson(json.decode(str));

String ordersDbResponseToJson(OrdersDbResponse data) =>
    json.encode(data.toJson());

class OrdersDbResponse {
  final bool success;
  final String? msg;
  final List<Datum> data;

  OrdersDbResponse({
    required this.success,
    this.msg,
    required this.data,
  });

  factory OrdersDbResponse.fromJson(Map<String, dynamic> json) =>
      OrdersDbResponse(
        success: json["success"],
        msg: json["msg"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  final String description;
  final double price;
  final DateTime orderDeliveryDate;
  final double? discount;
  final String? additionalThings;
  final bool delivered;
  final bool paid;
  final Id clientId;
  final Id userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String uid;
  final double advancePayment;
  final int advancePaymentType;
  final int totalProduct;

  Datum(
      {required this.description,
      required this.price,
      required this.orderDeliveryDate,
      this.discount,
      this.additionalThings,
      required this.delivered,
      required this.paid,
      required this.clientId,
      required this.userId,
      required this.createdAt,
      required this.updatedAt,
      required this.uid,
      required this.advancePayment,
      required this.advancePaymentType,
      required this.totalProduct});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
      description: json["description"],
      price: double.parse(json["price"].toString()),
      orderDeliveryDate: DateTime.parse(json["order_delivery_date"]),
      discount: double.parse(json["discount"].toString()),
      additionalThings: json["additional_things"],
      delivered: json["delivered"],
      paid: json["paid"],
      clientId: Id.fromJson(json["client_id"]),
      userId: Id.fromJson(json["user_id"]),
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      uid: json["uid"],
      advancePayment: double.parse(json["advance_payment"].toString()),
      advancePaymentType: json["advance_payment_type"],
      totalProduct: json["total_products"]);

  Map<String, dynamic> toJson() => {
        "description": description,
        "price": price,
        "order_delivery_date": orderDeliveryDate.toIso8601String(),
        "discount": discount,
        "additional_things": additionalThings ?? "",
        "delivered": delivered,
        "paid": paid,
        "client_id": clientId.toJson(),
        "user_id": userId.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "uid": uid,
        "advance_payment": advancePayment,
        "advance_payment_type": advancePaymentType,
        "total_products": totalProduct
      };
}

class Id {
  final String id;
  final String name;
  final String fatherSurname;
  final String? motherSurname;

  Id({
    required this.id,
    required this.name,
    required this.fatherSurname,
    this.motherSurname,
  });

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        id: json["_id"],
        name: json["name"],
        fatherSurname: json["father_surname"],
        motherSurname: json["mother_surname"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "father_surname": fatherSurname,
        "mother_surname": motherSurname,
      };
}
