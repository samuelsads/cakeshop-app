import 'package:cakeshopapp/domain/datasources/payment_datasource.dart';
import 'package:cakeshopapp/domain/entities/payment.dart';
import 'package:cakeshopapp/domain/entities/save.dart';
import 'package:cakeshopapp/domain/repositories/payment_repository.dart';

class PaymentRepositoryImpl extends PaymentRepository {
  final PaymentDataSource dataSource;

  PaymentRepositoryImpl({required this.dataSource});
  @override
  Future<Save> savePayment(Map<String, dynamic> data) async {
    return await dataSource.savePayment(data);
  }

  @override
  Future<List<Payment>> getAll(String id, bool delivered) async {
    return await dataSource.getAll(id, delivered);
  }
}
