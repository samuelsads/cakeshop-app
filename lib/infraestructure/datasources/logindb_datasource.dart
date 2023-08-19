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
    final data = {"email": email, "password": password};

    final response = await dio.post("/login", data: json.encode(data));

    final loginDbResponse = LoginResponse.fromJson(response.data);

    Login login = LoginMapper.loginDbEntity(loginDbResponse);
    return login;
  }
}
