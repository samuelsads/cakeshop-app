import 'package:cakeshopapp/domain/entities/payment.dart';
import 'package:cakeshopapp/domain/entities/save.dart';

abstract class PaymentRepository {
  Future<Save> savePayment(Map<String, dynamic> data);

  Future<List<Payment>> getAll(String id, bool delivered);
}
