import 'package:cakeshopapp/domain/datasources/login_datasource.dart';
import 'package:cakeshopapp/domain/entities/login.dart';
import 'package:cakeshopapp/domain/repositories/login_repository.dart';

class LoginRepositoryImp extends LoginRepository {
  final LoginDataSource dataSource;

  LoginRepositoryImp({required this.dataSource});

  @override
  Future<Login> login(String email, String password) async {
    return await dataSource.login(email, password);
  }

  @override
  Future<Login> verifyToken(String token) async {
    return await dataSource.verifyToken(token);
  }
}
