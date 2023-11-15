import 'package:cakeshopapp/domain/entities/order.dart';
import 'package:cakeshopapp/domain/entities/payment.dart';

class ClientDetails {
  Order order;
  List<Payment> payments;

  ClientDetails({required this.order, required this.payments});
}
