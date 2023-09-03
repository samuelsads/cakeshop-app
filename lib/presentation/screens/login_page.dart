import 'package:cakeshopapp/config/constants/security_token.dart';
import 'package:cakeshopapp/config/theme/boxdecoration_custom.dart';
import 'package:cakeshopapp/presentation/animations/slide_route_animation.dart';
import 'package:cakeshopapp/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:cakeshopapp/presentation/providers/login_provider.dart';
import 'package:cakeshopapp/presentation/screens/main_page.dart';
import 'package:cakeshopapp/presentation/viewmodels/viewmodel_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

late TextEditingController email;
late TextEditingController password;

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxdecorationCustom.customBoxdecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
            child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(24)),
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 24, bottom: 24),
                child: const Text(
                  "Iniciar sesión",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(8)),
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    hintText: "ejemplo@ejemplo.com",
                    counterStyle: const TextStyle(color: Colors.white),
                    hintStyle:
                        const TextStyle(color: Colors.black, fontSize: 14),
                    contentPadding:
                        const EdgeInsets.only(left: 16, top: 20, right: 16),
                    fillColor: const Color(0xffFFF9F5).withOpacity(0.10),
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color(0xffFFF9F5).withOpacity(0.70),
                          width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color(0xffFFF9F5).withOpacity(0.70),
                          width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color(0xffFFF9F5).withOpacity(0.70),
                          width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color(0xffFFF9F5).withOpacity(0.70),
                          width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color(0xffFFF9F5).withOpacity(0.70),
                          width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(8)),
                child: TextFormField(
                  controller: password,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: "Contraseña",
                    counterStyle: const TextStyle(color: Colors.white),
                    hintStyle:
                        const TextStyle(color: Colors.black, fontSize: 14),
                    contentPadding:
                        const EdgeInsets.only(left: 16, top: 20, right: 16),
                    fillColor: const Color(0xffFFF9F5).withOpacity(0.10),
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color(0xffFFF9F5).withOpacity(0.70),
                          width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color(0xffFFF9F5).withOpacity(0.70),
                          width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color(0xffFFF9F5).withOpacity(0.70),
                          width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color(0xffFFF9F5).withOpacity(0.70),
                          width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color(0xffFFF9F5).withOpacity(0.70),
                          width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state.loginSuccess) {
                    SecurityToken().saveToken(
                        BlocProvider.of<LoginBloc>(context)
                            .state
                            .login!
                            .token
                            .toString());
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          SlideRoute(page: const MainPage()),
                          (Route<dynamic> route) => false);
                    });
                  }

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                        onPressed: () async {
                          final bloc = BlocProvider.of<LoginBloc>(context);
                          await ViewmodelLogin()
                              .login(email.text, password.text, bloc);
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.black,
                        ),
                        child: const Text(
                          "Iniciar sesión",
                          style: TextStyle(color: Colors.white),
                        )),
                  );
                },
              )
            ],
          ),
        )),
      ),
    );
  }
}
