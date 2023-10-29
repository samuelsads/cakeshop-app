import 'package:cakeshopapp/config/constants/security_token.dart';
import 'package:cakeshopapp/domain/entities/login.dart';
import 'package:cakeshopapp/presentation/blocs/login_bloc/login_bloc.dart';

class ViewmodelLoading {
  Future<bool> initPage(LoginBloc bloc) async {
    final token = await SecurityToken.getToken();
    if (token.isNotEmpty) {
      // Verificar que todo este bien
      Login data = await bloc.verifyToken(token);

      if (!data.success) {
        await SecurityToken.deleteToken();
        return false;
      }
      SecurityToken().saveToken(data.token);

      return true;
    }

    return false;
  }
}
