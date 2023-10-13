// To parse this JSON data, do
//
//     final paymentsDbResponse = paymentsDbResponseFromJson(jsonString);

import 'dart:convert';

PaymentsDbResponse paymentsDbResponseFromJson(String str) =>
    PaymentsDbResponse.fromJson(json.decode(str));

String paymentsDbResponseToJson(PaymentsDbResponse data) =>
    json.encode(data.toJson());

class PaymentsDbResponse {
  bool success;
  String? msg;
  List<Datum>? data;

  PaymentsDbResponse({
    required this.success,
    this.msg,
    this.data,
  });

  factory PaymentsDbResponse.fromJson(Map<String, dynamic> json) =>
      PaymentsDbResponse(
        success: json["success"],
        msg: json["msg"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "msg": msg,
        "data": List<dynamic>.from((data ?? []).map((x) => x.toJson())),
      };
}

class Datum {
  final double payment;
  final int paymentType;
  final OrderId orderId;
  final UserId userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String uid;

  Datum({
    required this.payment,
    required this.paymentType,
    required this.orderId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.uid,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        payment: double.parse(json["payment"].toString()),
        paymentType: json["payment_type"],
        orderId: OrderId.fromJson(json["order_id"]),
        userId: UserId.fromJson(json["user_id"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "payment": payment,
        "payment_type": paymentType,
        "order_id": orderId.toJson(),
        "user_id": userId.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "uid": uid,
      };
}

class OrderId {
  final String id;
  final String description;
  final int price;
  final DateTime orderDeliveryDate;
  final int discount;
  final String additionalThings;
  final bool delivered;
  final bool paid;
  final int advancePayment;
  final int advancePaymentType;
  final int totalProducts;
  final String clientId;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  OrderId({
    required this.id,
    required this.description,
    required this.price,
    required this.orderDeliveryDate,
    required this.discount,
    required this.additionalThings,
    required this.delivered,
    required this.paid,
    required this.advancePayment,
    required this.advancePaymentType,
    required this.totalProducts,
    required this.clientId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory OrderId.fromJson(Map<String, dynamic> json) => OrderId(
        id: json["_id"],
        description: json["description"],
        price: json["price"],
        orderDeliveryDate: DateTime.parse(json["order_delivery_date"]),
        discount: json["discount"],
        additionalThings: json["additional_things"],
        delivered: json["delivered"],
        paid: json["paid"],
        advancePayment: json["advance_payment"],
        advancePaymentType: json["advance_payment_type"],
        totalProducts: json["total_products"],
        clientId: json["client_id"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "description": description,
        "price": price,
        "order_delivery_date": orderDeliveryDate.toIso8601String(),
        "discount": discount,
        "additional_things": additionalThings,
        "delivered": delivered,
        "paid": paid,
        "advance_payment": advancePayment,
        "advance_payment_type": advancePaymentType,
        "total_products": totalProducts,
        "client_id": clientId,
        "user_id": userId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class UserId {
  final String id;
  final String name;
  final String fatherSurname;
  final String motherSurname;
  final String email;
  final String password;
  final int role;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  UserId({
    required this.id,
    required this.name,
    required this.fatherSurname,
    required this.motherSurname,
    required this.email,
    required this.password,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["_id"],
        name: json["name"],
        fatherSurname: json["father_surname"],
        motherSurname: json["mother_surname"],
        email: json["email"],
        password: json["password"],
        role: json["role"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "father_surname": fatherSurname,
        "mother_surname": motherSurname,
        "email": email,
        "password": password,
        "role": role,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
