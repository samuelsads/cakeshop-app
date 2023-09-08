import 'dart:convert';

import 'package:cakeshopapp/config/constants/constans.dart';
import 'package:cakeshopapp/config/constants/security_token.dart';
import 'package:cakeshopapp/domain/datasources/order_datasource.dart';
import 'package:cakeshopapp/domain/entities/order.dart';
import 'package:cakeshopapp/domain/entities/save.dart';
import 'package:cakeshopapp/domain/entities/total_order.dart';
import 'package:cakeshopapp/infraestructure/mappers/order_mapper.dart';
import 'package:cakeshopapp/infraestructure/models/ordersdb/orderdb_response.dart';
import 'package:cakeshopapp/infraestructure/models/ordersdb/savedb_response.dart';
import 'package:cakeshopapp/infraestructure/models/ordersdb/totalorderdo_response.dart';
import 'package:dio/dio.dart';

class OrderDataSourceImpl extends OrderDataSource {
  final dio = Dio(BaseOptions(baseUrl: "$BASE_URL/orders"));

  @override
  Future<List<Order>> getAll(int start, int limit, bool delivered) async {
    List<Order> order;
    String token = await SecurityToken.getToken();
    try {
      final response =
          await dio.get("/all?start=$start&limit=$limit&delivered=$delivered",
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
      final response = await dio.get("/total?delivered=$delivered",
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

  @override
  Future<Save> saveOrder(Map<String, dynamic> data) async {
    Save save;
    String token = await SecurityToken.getToken();

    try {
      final response = await dio.post("/new",
          data: json.encode(data),
          options: Options(headers: {
            'x-token': token,
          }));
      final saveOrderDbResponse = SavedbResponse.fromJson(response.data);
      save = OrderMapper.saveDbEntity(saveOrderDbResponse);
    } on DioException catch (e) {
      save = Save(success: false, msg: "Error");
    }

    return save;
  }
}
