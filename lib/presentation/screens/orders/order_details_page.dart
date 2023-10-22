import 'package:cakeshopapp/config/theme/boxdecoration_custom.dart';
import 'package:cakeshopapp/domain/entities/order.dart';
import 'package:cakeshopapp/presentation/blocs/payment_bloc/payment_bloc.dart';
import 'package:cakeshopapp/presentation/providers/color_provider.dart';
import 'package:cakeshopapp/presentation/providers/order_provider.dart';
import 'package:cakeshopapp/presentation/screens/orders/order_new_page.dart';
import 'package:cakeshopapp/presentation/viewmodels/viewmodel_orders.dart';
import 'package:cakeshopapp/presentation/viewmodels/viewmodel_payment.dart';
import 'package:cakeshopapp/presentation/widgets/done_order_widget.dart';
import 'package:cakeshopapp/presentation/widgets/history_of_payment.dart';
import 'package:cakeshopapp/presentation/widgets/new_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({required this.order, Key? key}) : super(key: key);

  final Order order;

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

late TextEditingController advancedPaymentController;

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  void initState() {
    super.initState();
    advancedPaymentController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        ViewmodelPayment()
            .getAll(widget.order.uid, BlocProvider.of<PaymentBloc>(context));
      }
    });
  }

  @override
  void dispose() {
    advancedPaymentController.dispose();
    super.dispose();
  }

  Future<dynamic> _doneOrder() async {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24))),
              child: DoneOrderWidget(
                uuid: widget.order.uid,
              )),
        );
      },
    );
  }

  Future<dynamic> _advancedPayment() async {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24))),
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 24),
                    child: Column(
                      children: [
                        const Text(
                          "Pagos",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.read<OrderProvider>().currentPage = 0;
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: (context.select(
                                                  (OrderProvider value) =>
                                                      value.currentPage) ==
                                              0)
                                          ? Colors.black
                                          : Colors.grey.shade200),
                                  child: Text(
                                    "Nuevo pago",
                                    style: TextStyle(
                                        color: (context.select(
                                                    (OrderProvider value) =>
                                                        value.currentPage) ==
                                                0)
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  context.read<OrderProvider>().currentPage = 1;
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: (context.select(
                                                  (OrderProvider value) =>
                                                      value.currentPage) ==
                                              1)
                                          ? Colors.black
                                          : Colors.grey.shade200),
                                  child: Text(
                                    "Historial",
                                    style: TextStyle(
                                        color: (context.select(
                                                    (OrderProvider value) =>
                                                        value.currentPage) ==
                                                1)
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: MediaQuery.of(context).size.width,
                          child: PageView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: context.select(
                                (OrderProvider order) => order.pageController),
                            children: [
                              NewPayment(
                                order: widget.order,
                                update: true,
                                advancedPaymentController:
                                    advancedPaymentController,
                              ),
                              HistoryOfPayment(
                                order: widget.order,
                              ),
                            ],
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors
          .transparent, // Color transparente para la barra de notificaciones
    ));
    return Container(
      decoration: BoxdecorationCustom.customBoxdecoration(context),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
                heroTag: 'btn1',
                backgroundColor: Colors.black,
                child: const Icon(Icons.attach_money),
                onPressed: () {
                  context.read<OrderProvider>().changePage(0);
                  _advancedPayment();
                }),
            FloatingActionButton(
                heroTag: 'btn2',
                backgroundColor: Colors.black,
                child: const Icon(Icons.check),
                onPressed: () => _doneOrder())
          ],
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              _TopCard(order: widget.order),
              Positioned(
                bottom: 0,
                child: Container(
                  margin: const EdgeInsets.only(left: 0, right: 0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.7,
                  decoration: BoxDecoration(
                      color: context
                          .select((ColorProvider value) => value.buttonColor),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _DateCard(order: widget.order),
                      const _LinearWidget(),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 12, right: 12, top: 12, bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Cliente: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            Text(
                                "${widget.order.clientId!.name} ${widget.order.clientId!.fatherSurname} ${widget.order.clientId?.motherSurname ?? ""}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 24, right: 24, top: 12, bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Total de productos: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                            Text(
                              widget.order.totalProduct.toString(),
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _CardPayment(
                              money: widget.order.price, title: "Total"),
                          _CardPayment(
                              money: widget.order.advancePayment,
                              title: "Anticipo"),
                          _CardPayment(
                              money: widget.order.discount, title: "Descuento"),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          _modalSheetMoreDetails(context);
                        },
                        child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Text(
                              widget.order.description,
                              textAlign: TextAlign.justify,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _modalSheetMoreDetails(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8))),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 24, bottom: 24),
                        child: const Text(
                          "Detalles del pedido",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        widget.order.description,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.all(16),
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey),
                if (widget.order.additionalThings.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 0, bottom: 24),
                          child: const Text(
                            "Otros",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          widget.order.additionalThings,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                if (widget.order.additionalThings.isNotEmpty)
                  Container(
                      margin: const EdgeInsets.all(16),
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 0, bottom: 24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  child: const Text(
                                    "Creado por",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  "${widget.order.userId!.name} ${widget.order.userId!.fatherSurname} ${widget.order.userId?.motherSurname ?? ''}",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 0, bottom: 24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  child: const Text(
                                    "Creado el",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  ViewmodelOrders()
                                      .formattedDate(widget.order.createdAt),
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LinearWidget extends StatelessWidget {
  const _LinearWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 1,
      color: Colors.grey,
    );
  }
}

class _DateCard extends StatelessWidget {
  const _DateCard({
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      child: Text(ViewmodelOrders().formattedDate(order.orderDeliveryDate),
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }
}

class _CardPayment extends StatelessWidget {
  const _CardPayment({
    required this.money,
    required this.title,
  });

  final double money;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12, top: 0, bottom: 10),
      width: 100,
      height: 100,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            NumberFormat.currency(
                    symbol: '\$', decimalDigits: 2, locale: 'es_MX')
                .format(money),
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(title,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14)),
          )
        ],
      ),
    );
  }
}

class _TopCard extends StatelessWidget {
  const _TopCard({
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Stack(
        children: [
          Image.asset("assets/01.jpeg",
              fit: BoxFit.cover,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5),
          Container(
            margin: const EdgeInsets.only(top: 24),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            width: double.infinity,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(50)),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderNewPage(
                                    update: true,
                                    orderUpd: order,
                                  ))),
                      child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(50)),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
