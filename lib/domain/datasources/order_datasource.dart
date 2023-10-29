import 'package:cakeshopapp/domain/entities/order.dart';
import 'package:cakeshopapp/domain/entities/save.dart';
import 'package:cakeshopapp/domain/entities/total_order.dart';

abstract class OrderDataSource {
  Future<List<Order>> getAll(int start, int limit, bool delivered);
  Future<TotalOrder> getTotal(bool delivered);

  Future<Save> saveOrder(Map<String, dynamic> data);

  Future<Save> updateOrder(Map<String, dynamic> data);

  Future<Save> updateOrderStatus(String uuid);
}
