import 'package:cakeshopapp/domain/entities/login.dart';

abstract class LoginDataSource {
  Future<Login> login(String email, String password);
}
