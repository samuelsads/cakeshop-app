import 'package:cakeshopapp/domain/entities/order.dart';
import 'package:cakeshopapp/domain/entities/total_order.dart';
import 'package:cakeshopapp/presentation/blocs/order_bloc/order_bloc.dart';
import 'package:cakeshopapp/presentation/providers/color_provider.dart';
import 'package:cakeshopapp/presentation/providers/order_provider.dart';
import 'package:cakeshopapp/presentation/screens/orders/order_details_page.dart';
import 'package:cakeshopapp/presentation/screens/orders/order_new_page.dart';
import 'package:cakeshopapp/presentation/viewmodels/viewmodel_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

late ScrollController scrollController;

class _OrdersPageState extends State<OrdersPage>
    with AutomaticKeepAliveClientMixin {
  void scrollDownOrUp() {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      context.read<OrderProvider>().downOrUp = false;
    } else if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      context.read<OrderProvider>().downOrUp = true;
    }
  }

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController()..addListener(scrollDownOrUp);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        ViewmodelOrders()
            .getAllOrders(0, 10, false, BlocProvider.of<OrderBloc>(context));
      }
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollDownOrUp);
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state.orderLoading || state.orderInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.orderSuccess) {
            List<Order> data = state.order ?? [];
            TotalOrder total = state.total!;
            return _orderBody(total, data);
          }

          if (state.orderError) {
            return const Center(
              child: Text("ERRORRRRRRR"),
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity:
            (context.select((OrderProvider value) => value.downOrUp)) ? 0 : 1,
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          child: FloatingActionButton.extended(
              backgroundColor:
                  context.select((ColorProvider value) => value.buttonColor),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OrderNewPage())),
              label: Row(
                children: [
                  Icon(
                    Icons.add,
                    color: context
                        .select((ColorProvider value) => value.textButtonColor),
                  ),
                  Text(
                    "Agregar pedido",
                    style: TextStyle(
                        color: context.select(
                            (ColorProvider value) => value.textButtonColor)),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  SafeArea _orderBody(TotalOrder total, List<Order> data) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            margin:
                const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 24),
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.grey.shade50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(12),
                  child: const Text(
                    "Ordenes",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _TotalCardWidget(
                      info: total.total,
                      title: "Total",
                      width: 80,
                      height: 100,
                    ),
                    _TotalCardWidget(
                      info: total.today,
                      title: "Hoy",
                      width: 80,
                      height: 100,
                    ),
                    _TotalCardWidget(
                      info: total.tomorrow,
                      title: "Mañana",
                      width: 80,
                      height: 100,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: data.length,
              itemBuilder: (context, index) {
                final information = data[index];
                return _ListItem(information: information);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class _ListItem extends StatelessWidget {
  const _ListItem({
    required this.information,
  });

  final Order information;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderDetailsPage(order: information)));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 24, right: 24, top: 8),
        width: double.infinity,
        height: 130,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.grey.shade100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 12, top: 20, bottom: 0),
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        information.totalProduct.toString(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      const Text("Productos",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14))
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 12, top: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            ViewmodelOrders()
                                .formattedDate(information.orderDeliveryDate),
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8, left: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "${information.clientId!.name} ${information.clientId!.fatherSurname} ${information.clientId?.motherSurname ?? ''}",
                                  style: const TextStyle(fontSize: 14)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 12, top: 8),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey.shade300),
                      child: Column(
                        children: [
                          Text(
                              NumberFormat.currency(
                                      symbol: '\$',
                                      decimalDigits: 2,
                                      locale: 'es_MX')
                                  .format(information.price),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TotalCardWidget extends StatelessWidget {
  const _TotalCardWidget(
      {required this.title,
      required this.info,
      required this.height,
      required this.width});

  final int info;
  final String title;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.only(top: 0, right: 12, left: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24), color: Colors.black),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            " $info",
            style: const TextStyle(
                fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
