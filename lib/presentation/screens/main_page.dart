import 'package:cakeshopapp/config/theme/boxdecoration_custom.dart';
import 'package:cakeshopapp/presentation/providers/color_provider.dart';
import 'package:cakeshopapp/presentation/providers/main_page_provider.dart';
import 'package:cakeshopapp/presentation/screens/clients/client_page.dart';
import 'package:cakeshopapp/presentation/screens/orders/order_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxdecorationCustom.customBoxdecoration(context),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: _Pages(),
        bottomNavigationBar: _Navigator(),
      ),
    );
  }
}

class _Pages extends StatefulWidget {
  const _Pages({Key? key}) : super(key: key);

  @override
  State<_Pages> createState() => __PagesState();
}

class __PagesState extends State<_Pages> {
  List items = [const OrdersPage(), const ClientPage()];
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      controller: context.read<MainPageProvider>().pageController,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return items[index];
      },
    );
  }
}

class _Navigator extends StatefulWidget {
  const _Navigator({Key? key}) : super(key: key);

  @override
  State<_Navigator> createState() => __NavigatorState();
}

class __NavigatorState extends State<_Navigator> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<MainPageProvider>();
    return BottomNavigationBar(
        backgroundColor:
            context.select((ColorProvider value) => value.buttonColor),
        unselectedItemColor:
            context.select((ColorProvider value) => value.textButtonColor),
        selectedItemColor:
            context.select((ColorProvider value) => value.textButtonColor),
        currentIndex:
            context.select((MainPageProvider value) => value.currentPage),
        onTap: (i) {
          provider.currentPage = i;
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.check),
              label: "Ordenes",
              backgroundColor: Colors.white),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Clientes")
        ]);
  }
}
