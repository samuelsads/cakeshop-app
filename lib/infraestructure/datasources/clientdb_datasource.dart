import 'dart:convert';

import 'package:cakeshopapp/config/constants/constans.dart';
import 'package:cakeshopapp/config/constants/security_token.dart';
import 'package:cakeshopapp/domain/datasources/client_datasource.dart';
import 'package:cakeshopapp/domain/entities/client.dart';
import 'package:cakeshopapp/domain/entities/cliente_details.dart';
import 'package:cakeshopapp/domain/entities/save.dart';
import 'package:cakeshopapp/infraestructure/mappers/basic_mapper.dart';
import 'package:cakeshopapp/infraestructure/mappers/client_mapper.dart';
import 'package:cakeshopapp/infraestructure/models/clientdb/client_detailsdb_response.dart';
import 'package:cakeshopapp/infraestructure/models/clientdb/clientdb_search_response.dart';
import 'package:cakeshopapp/infraestructure/models/ordersdb/savedb_response.dart';
import 'package:dio/dio.dart';

class ClientdbDatasourceImpl extends ClientDataSource {
  final dio = Dio(BaseOptions(baseUrl: "$BASE_URL/client"));

  @override
  Future<List<Client>> searchClient(String search) async {
    List<Client> searchList;
    String token = await SecurityToken.getToken();
    try {
      final response = await dio.get("/search?search=$search",
          options: Options(headers: {
            'x-token': token,
          }));

      final clientDbResponse = ClientdbSearchResponse.fromJson(response.data);

      searchList = clientDbResponse.data
          .map((e) => ClientMapper.clientDbEntity(e))
          .toList();
    } on DioException catch (e) {
      print(e);
      searchList = [];
    }

    return searchList;
  }

  @override
  Future<List<Client>> getAll(int start, int limit) async {
    List<Client> searchList;
    String token = await SecurityToken.getToken();
    try {
      final response = await dio.get("/all?limit=$limit&start=$start",
          options: Options(headers: {
            'x-token': token,
          }));

      final clientDbResponse = ClientdbSearchResponse.fromJson(response.data);

      searchList = clientDbResponse.data
          .map((e) => ClientMapper.clientDbEntity(e))
          .toList();
    } on DioException catch (e) {
      print(e);
      searchList = [];
    }

    return searchList;
  }

  @override
  Future<Save> save(Map<String, dynamic> data) async {
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
    } on DioException {
      save = Save(success: false, msg: "Error", id: "");
    }

    return save;
  }

  @override
  Future<List<ClientDetails>> clientDetails(String clientId) async {
    List<ClientDetails> data = [];
    String token = await SecurityToken.getToken();

    try {
      final response = await dio.get("/findById?id=$clientId",
          options: Options(headers: {
            'x-token': token,
          }));
      final clientDetailsResponse =
          ClientDetailsDbResponse.fromJson(response.data);
      data = (clientDetailsResponse.result ?? [])
          .map((e) => ClientMapper.clientDetailsDbEntity(e))
          .toList();
    } on DioException {
      data = [];
    }

    return data;
  }

  @override
  Future<Save> update(Map<String, dynamic> data) async {
    Save save;
    String token = await SecurityToken.getToken();

    try {
      final response = await dio.patch("/update",
          data: json.encode(data),
          options: Options(headers: {
            'x-token': token,
          }));
      final saveOrderDbResponse = SavedbResponse.fromJson(response.data);
      save = BasicMapper.saveDbEntity(saveOrderDbResponse);
    } on DioException {
      save = Save(success: false, msg: "Error", id: "");
    }

    return save;
  }
}
