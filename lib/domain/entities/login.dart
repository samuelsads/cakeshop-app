import 'package:cakeshopapp/domain/entities/user.dart';

class Login {
  final bool success;
  final User? user;
  final String token;
  final String? msg;

  Login({required this.success, this.user, required this.token, this.msg});
}
