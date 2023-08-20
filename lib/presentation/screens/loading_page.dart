import 'package:cakeshopapp/presentation/animations/scale_route_animation.dart';
import 'package:cakeshopapp/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:cakeshopapp/presentation/screens/login_page.dart';
import 'package:cakeshopapp/presentation/screens/main_page.dart';
import 'package:cakeshopapp/presentation/viewmodels/viewmodel_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ViewmodelLoading()
          .initPage(BlocProvider.of<LoginBloc>(context))
          .then((value) {
        if (value) {
          Navigator.pushReplacement(
              context, ScaleRoute(page: const MainPage()));
        } else {
          Navigator.pushReplacement(
              context, ScaleRoute(page: const LoginPage()));
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.pink.shade100, Colors.pink.shade200])),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      ),
    );
  }
}
