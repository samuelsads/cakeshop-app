import 'dart:convert';

import 'package:cakeshopapp/config/constants/constans.dart';
import 'package:cakeshopapp/domain/datasources/login_datasource.dart';
import 'package:cakeshopapp/domain/entities/login.dart';
import 'package:cakeshopapp/infraestructure/mappers/login_mapper.dart';
import 'package:cakeshopapp/infraestructure/models/logindb/logindb_response.dart';

import 'package:dio/dio.dart';

class LoginDataSourceImpl extends LoginDataSource {
  final dio = Dio(BaseOptions(baseUrl: BASE_URL));

  @override
  Future<Login> login(String email, String password) async {
    Login login;
    try {
      final data = {"email": email, "password": password};

      final response = await dio.post("/login", data: json.encode(data));

      final loginDbResponse = LoginResponse.fromJson(response.data);

      login = LoginMapper.loginDbEntity(loginDbResponse);
    } on DioException catch (e) {
      login = Login(success: false, token: "");
    }

    return login;
  }

  @override
  Future<Login> verifyToken(String token) async {
    Login login;
    try {
      final response = await dio.get("/login/renew",
          options: Options(headers: {"x-token": token}));

      final loginDbResponse = LoginResponse.fromJson(response.data);

      login = LoginMapper.loginDbEntity(loginDbResponse);
    } on DioException catch (e) {
      login = Login(success: false, token: "");
    }

    return login;
  }
}
