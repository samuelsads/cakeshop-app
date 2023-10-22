import 'package:cakeshopapp/config/sharepreferences/color_preference.dart';
import 'package:cakeshopapp/infraestructure/datasources/clientdb_datasource.dart';
import 'package:cakeshopapp/infraestructure/datasources/logindb_datasource.dart';
import 'package:cakeshopapp/infraestructure/datasources/orderdb_datasource.dart';
import 'package:cakeshopapp/infraestructure/datasources/paymentdb_datasource_impl.dart';
import 'package:cakeshopapp/infraestructure/repositories/client_repository_impl.dart';
import 'package:cakeshopapp/infraestructure/repositories/login_repository_impl.dart';
import 'package:cakeshopapp/infraestructure/repositories/order_repository_impl.dart';
import 'package:cakeshopapp/infraestructure/repositories/payment_repository_impl.dart';
import 'package:cakeshopapp/presentation/blocs/client_bloc/client_bloc.dart';
import 'package:cakeshopapp/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:cakeshopapp/presentation/blocs/order_bloc/order_bloc.dart';
import 'package:cakeshopapp/presentation/blocs/payment_bloc/payment_bloc.dart';
import 'package:cakeshopapp/presentation/providers/color_provider.dart';
import 'package:cakeshopapp/presentation/providers/login_provider.dart';
import 'package:cakeshopapp/presentation/providers/main_page_provider.dart';
import 'package:cakeshopapp/presentation/providers/order_provider.dart';
import 'package:cakeshopapp/presentation/screens/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  //initializeDateFormatting();
  WidgetsFlutterBinding.ensureInitialized();
  await ColorPreference().initPrefs();
  ColorPreference().primaryColor = 1;
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) =>
          LoginBloc(LoginRepositoryImp(dataSource: LoginDataSourceImpl())),
    ),
    BlocProvider(
      create: (context) =>
          OrderBloc(OrderRepositoryImpl(dataSource: OrderDataSourceImpl())),
    ),
    BlocProvider(
      create: (context) => ClientBloc(
          ClientRepositoryImpl(dataSource: ClientdbDatasourceImpl())),
    ),
    BlocProvider(
      create: (context) => PaymentBloc(
          PaymentRepositoryImpl(dataSource: PaymentDataSourceImp())),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ColorProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MainPageProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginProvider(
              LoginRepositoryImp(dataSource: LoginDataSourceImpl())),
        )
      ],
      child: const MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en'), // English
          Locale('es'), // Spanish
        ],
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        home: LoadingPage(),
      ),
    );
  }
}
