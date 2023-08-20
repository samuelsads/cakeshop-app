import 'package:cakeshopapp/domain/repositories/login_repository.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final LoginRepository loginRepository;

  LoginProvider(this.loginRepository);

  Future<void> login(String email, String password) async {
    await loginRepository.login("samueldzibsads@gmail.com", "123456");
  }
}
