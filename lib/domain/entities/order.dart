import 'package:cakeshopapp/domain/entities/client.dart';
import 'package:cakeshopapp/domain/entities/user.dart';

class Order {
  String description;
  double price;
  DateTime orderDeliveryDate;
  double discount;
  String additionalThings;
  bool delivered;
  bool paid;
  Client clientId;
  User userId;
  String uid;
  DateTime createdAt;
  double advancePayment;
  int advancePaymentType;
  int totalProduct;

  Order(
      {required this.description,
      required this.price,
      required this.orderDeliveryDate,
      required this.discount,
      required this.additionalThings,
      required this.delivered,
      required this.paid,
      required this.clientId,
      required this.userId,
      required this.uid,
      required this.createdAt,
      required this.advancePayment,
      required this.advancePaymentType,
      required this.totalProduct});
}
