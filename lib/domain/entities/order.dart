import 'package:cakeshopapp/domain/entities/client.dart';
import 'package:cakeshopapp/domain/entities/user.dart';

class Order {
  final String description;
  final double price;
  final DateTime orderDeliveryDate;
  final double discount;
  final String? additionalThings;
  final bool delivered;
  final bool paid;
  final Client clientId;
  final User userId;
  final String uid;
  final DateTime createdAt;
  final double advancePayment;
  final int advancePaymentType;
  final int totalProduct;

  Order(
      {required this.description,
      required this.price,
      required this.orderDeliveryDate,
      required this.discount,
      this.additionalThings,
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
