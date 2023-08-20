import 'package:cakeshopapp/infraestructure/datasources/logindb_datasource.dart';
import 'package:cakeshopapp/infraestructure/repositories/login_repository_impl.dart';
import 'package:cakeshopapp/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:cakeshopapp/presentation/providers/login_provider.dart';
import 'package:cakeshopapp/presentation/providers/main_page_provider.dart';
import 'package:cakeshopapp/presentation/screens/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) =>
            LoginBloc(LoginRepositoryImp(dataSource: LoginDataSourceImpl())),
      )
    ], child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MainPageProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginProvider(
              LoginRepositoryImp(dataSource: LoginDataSourceImpl())),
        )
      ],
      child: const MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        home: LoadingPage(),
      ),
    );
  }
}
