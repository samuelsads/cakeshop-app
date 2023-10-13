import 'package:cakeshopapp/domain/entities/order.dart';
import 'package:cakeshopapp/domain/entities/user.dart';

class Payment {
  double payment;
  int paymentType;
  String? orderId;
  Order? order;
  User? user;
  DateTime? createdAt;
  DateTime? updateAt;

  Payment(
      {required this.payment,
      required this.paymentType,
      this.order,
      this.orderId,
      this.user,
      createdAt,
      updateAt});
}
