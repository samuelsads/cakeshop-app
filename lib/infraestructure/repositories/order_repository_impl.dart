import 'package:cakeshopapp/domain/datasources/order_datasource.dart';
import 'package:cakeshopapp/domain/entities/order.dart';
import 'package:cakeshopapp/domain/entities/save.dart';
import 'package:cakeshopapp/domain/entities/total_order.dart';
import 'package:cakeshopapp/domain/repositories/order_repository.dart';

class OrderRepositoryImpl extends OrderRepository {
  final OrderDataSource dataSource;

  OrderRepositoryImpl({required this.dataSource});

  @override
  Future<List<Order>> getAll(int start, int limit, bool delivered) async {
    return await dataSource.getAll(start, limit, delivered);
  }

  @override
  Future<TotalOrder> getTotal(bool delivered) async {
    return await dataSource.getTotal(delivered);
  }

  @override
  Future<Save> saveOrder(Map<String, dynamic> data) async {
    return await dataSource.saveOrder(data);
  }

  @override
  Future<Save> updateOrder(Map<String, dynamic> data) async {
    return await dataSource.updateOrder(data);
  }

  @override
  Future<Save> updateOrderStatus(String uuid) async {
    return await dataSource.updateOrderStatus(uuid);
  }
}
