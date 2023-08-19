import 'package:cakeshopapp/domain/entities/login.dart';
import 'package:cakeshopapp/domain/entities/user.dart';
import 'package:cakeshopapp/infraestructure/models/logindb/logindb_response.dart';

class LoginMapper {
  static Login loginDbEntity(LoginResponse login) => Login(
      success: login.success,
      token: (login.token == null) ? "" : login.token.toString(),
      msg: (login.msg == null) ? null : login.msg.toString(),
      user: User(
          name: login.user!.name,
          fatherSurname: login.user!.fatherSurname,
          motherSurname: login.user?.motherSurname.toString(),
          email: login.user!.email,
          role: login.user!.role,
          uid: login.user!.uid));
}
