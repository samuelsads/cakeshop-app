import 'package:cakeshopapp/domain/entities/order.dart';
import 'package:cakeshopapp/domain/entities/total_order.dart';

abstract class OrderRepository {
  Future<List<Order>> getAll(int start, int limit, bool delivered);

  Future<TotalOrder> getTotal(bool delivered);
}
