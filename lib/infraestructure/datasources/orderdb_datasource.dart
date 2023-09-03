import 'package:cakeshopapp/config/constants/constans.dart';
import 'package:cakeshopapp/config/constants/security_token.dart';
import 'package:cakeshopapp/domain/datasources/order_datasource.dart';
import 'package:cakeshopapp/domain/entities/order.dart';
import 'package:cakeshopapp/domain/entities/total_order.dart';
import 'package:cakeshopapp/infraestructure/mappers/order_mapper.dart';
import 'package:cakeshopapp/infraestructure/models/ordersdb/orderdb_response.dart';
import 'package:cakeshopapp/infraestructure/models/ordersdb/totalorderdo_response.dart';
import 'package:dio/dio.dart';

class OrderDataSourceImpl extends OrderDataSource {
  final dio = Dio(BaseOptions(baseUrl: BASE_URL));

  @override
  Future<List<Order>> getAll(int start, int limit, bool delivered) async {
    List<Order> order;
    String token = await SecurityToken.getToken();
    try {
      final response = await dio.get(
          "/orders/all?start=$start&limit=$limit&delivered=$delivered",
          options: Options(headers: {
            'x-token': token,
          }));

      final orderDbResponse = OrdersDbResponse.fromJson(response.data);

      order = orderDbResponse.data
          .map((e) => OrderMapper.orderDbEntity(e))
          .toList();
    } on DioException catch (e) {
      print(e);
      order = [];
    }

    return order;
  }

  @override
  Future<TotalOrder> getTotal(bool delivered) async {
    TotalOrder total;
    String token = await SecurityToken.getToken();

    try {
      final response = await dio.get("/orders/total?delivered=$delivered",
          options: Options(headers: {
            'x-token': token,
          }));
      final totalOrderDbResponse = TotalOrderDbResponse.fromJson(response.data);

      total = OrderMapper.totalOrderDbEntity(totalOrderDbResponse);
    } on DioException catch (e) {
      total = TotalOrder(
          success: false,
          today: 0,
          tomorrow: 0,
          total: 0,
          msg: "Error al solicitar");
    }

    return total;
  }
}
