import 'package:cakeshopapp/presentation/blocs/login_bloc/login_bloc.dart';

class ViewmodelLogin {
  Future<void> login(String email, String password, LoginBloc bloc) async {
    if (email.trim().isNotEmpty && password.trim().isNotEmpty) {
      await bloc.login(email, password);
    }
  }
}
