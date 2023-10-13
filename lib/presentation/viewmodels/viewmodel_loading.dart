import 'package:cakeshopapp/config/constants/security_token.dart';
import 'package:cakeshopapp/domain/entities/login.dart';
import 'package:cakeshopapp/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:flutter/material.dart';

class ViewmodelLoading {
  Future<void> waitingToFinishing(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Opacity(
              opacity: 0.85,
              child: AlertDialog(
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                insetPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                content: Align(
                  child: Container(
                    width: 80,
                    height: 58,
                    decoration: BoxDecoration(
                        color: const Color(0xff313133).withOpacity(0.85),
                        borderRadius: BorderRadius.circular(8)),
                    child: Align(
                      child: Container(
                        width: 24,
                        height: 24,
                        child: const CircularProgressIndicator(
                          color: Color(0xffFFF9F5),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }

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
