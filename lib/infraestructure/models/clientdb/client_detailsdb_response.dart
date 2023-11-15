// To parse this JSON data, do
//
//     final clientDetailsDbResponse = clientDetailsDbResponseFromJson(jsonString);

import 'dart:convert';

ClientDetailsDbResponse clientDetailsDbResponseFromJson(String str) =>
    ClientDetailsDbResponse.fromJson(json.decode(str));

String clientDetailsDbResponseToJson(ClientDetailsDbResponse data) =>
    json.encode(data.toJson());

class ClientDetailsDbResponse {
  bool success;
  String? msg;
  List<Result>? result;

  ClientDetailsDbResponse({
    required this.success,
    this.msg,
    this.result,
  });

  factory ClientDetailsDbResponse.fromJson(Map<String, dynamic> json) =>
      ClientDetailsDbResponse(
        success: json["success"],
        msg: json["msg"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "msg": msg,
        "result": List<dynamic>.from((result ?? []).map((x) => x.toJson())),
      };
}

class Result {
  Order order;
  List<Payment> payments;

  Result({
    required this.order,
    required this.payments,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        order: Order.fromJson(json["order"]),
        payments: List<Payment>.from(
            json["payments"].map((x) => Payment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order": order.toJson(),
        "payments": List<dynamic>.from(payments.map((x) => x.toJson())),
      };
}

class Order {
  String description;
  double price;
  DateTime orderDeliveryDate;
  double discount;
  String additionalThings;
  bool delivered;
  bool paid;
  double advancePayment;
  int advancePaymentType;
  int totalProducts;
  String clientId;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;
  String uid;

  Order({
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
    required this.uid,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        description: json["description"],
        price: double.parse(json["price"].toString()),
        orderDeliveryDate: DateTime.parse(json["order_delivery_date"]),
        discount: double.parse(json["discount"].toString()),
        additionalThings: json["additional_things"],
        delivered: json["delivered"],
        paid: json["paid"],
        advancePayment: double.parse(json["advance_payment"].toString()),
        advancePaymentType: json["advance_payment_type"],
        totalProducts: json["total_products"],
        clientId: json["client_id"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
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
        "uid": uid,
      };
}

class Payment {
  double payment;
  int paymentType;
  String orderId;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;
  String uid;

  Payment({
    required this.payment,
    required this.paymentType,
    required this.orderId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.uid,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        payment: double.parse(json["payment"].toString()),
        paymentType: json["payment_type"],
        orderId: json["order_id"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "payment": payment,
        "payment_type": paymentType,
        "order_id": orderId,
        "user_id": userId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "uid": uid,
      };
}
