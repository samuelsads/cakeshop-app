import 'package:cakeshopapp/domain/entities/login.dart';

abstract class LoginRepository {
  Future<Login> login(String email, String password);

  Future<Login> verifyToken(String token);
}
