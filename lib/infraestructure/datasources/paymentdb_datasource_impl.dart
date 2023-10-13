import 'dart:convert';

import 'package:cakeshopapp/config/constants/constans.dart';
import 'package:cakeshopapp/config/constants/security_token.dart';
import 'package:cakeshopapp/domain/datasources/payment_datasource.dart';
import 'package:cakeshopapp/domain/entities/payment.dart';
import 'package:cakeshopapp/domain/entities/save.dart';
import 'package:cakeshopapp/infraestructure/mappers/basic_mapper.dart';
import 'package:cakeshopapp/infraestructure/mappers/payment_mapper.dart';
import 'package:cakeshopapp/infraestructure/models/ordersdb/savedb_response.dart';
import 'package:cakeshopapp/infraestructure/models/paymentdb/paymentdb_response.dart';
import 'package:dio/dio.dart';

class PaymentDataSourceImp extends PaymentDataSource {
  final dio = Dio(BaseOptions(baseUrl: "$BASE_URL/payments"));

  @override
  Future<Save> savePayment(Map<String, dynamic> data) async {
    Save save;
    String token = await SecurityToken.getToken();

    try {
      final response = await dio.post("/new",
          data: json.encode(data),
          options: Options(headers: {
            'x-token': token,
          }));
      final saveOrderDbResponse = SavedbResponse.fromJson(response.data);
      save = BasicMapper.saveDbEntity(saveOrderDbResponse);
    } on DioException catch (e) {
      save = Save(success: false, msg: "Error", id: "");
    }

    return save;
  }

  @override
  Future<List<Payment>> getAll(String id, bool delivered) async {
    List<Payment> payments = [];
    String token = await SecurityToken.getToken();

    try {
      final response = await dio.get("/all?id=$id",
          options: Options(headers: {
            'x-token': token,
          }));
      final getAllOrderDbResponse = PaymentsDbResponse.fromJson(response.data);
      payments = (getAllOrderDbResponse.data ?? [])
          .map((e) => PaymentMapper.payment(e))
          .toList();
    } on DioException catch (e) {
      payments = [];
    }
    return payments;
  }
}
