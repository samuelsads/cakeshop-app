import 'package:cakeshopapp/config/theme/boxdecoration_custom.dart';
import 'package:cakeshopapp/domain/entities/order.dart';
import 'package:cakeshopapp/presentation/viewmodels/viewmodel_orders.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({required this.order, Key? key}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxdecorationCustom.customBoxdecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _TopCard(order: order),
              Container(
                margin: const EdgeInsets.only(left: 8, right: 8),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _CardPayment(money: order.price, title: "Total"),
                        _CardPayment(
                            money: order.advancePayment, title: "Anticipo"),
                        _CardPayment(money: order.discount, title: "Descuento"),
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
                            order.description,
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
              )
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
                        order.description,
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
                if (order.additionalThings.isNotEmpty)
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
                          order.additionalThings,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                if (order.additionalThings.isNotEmpty)
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
                                  "${order.userId.name} ${order.userId.fatherSurname} ${order.userId.motherSurname}",
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
                                      .formattedDate(order.createdAt),
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

class _CardPayment extends StatelessWidget {
  const _CardPayment({
    super.key,
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
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.red.shade200, borderRadius: BorderRadius.circular(24)),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Stack(
        children: [
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
                          color: Colors.transparent,
                          child: const Icon(Icons.arrow_back)),
                    ),
                    const Spacer(),
                    Container(
                        height: 50,
                        color: Colors.transparent,
                        child: const Icon(Icons.edit))
                  ],
                ),
                const Spacer(),
                // Container(
                //   child: Text(
                //       NumberFormat.currency(
                //               symbol: '\$',
                //               decimalDigits: 2,
                //               locale: 'es_MX')
                //           .format(order.price),
                //       style: const TextStyle(
                //           color: Colors.white,
                //           fontSize: 16,
                //           fontWeight: FontWeight.bold)),
                // ),
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Text(
                      ViewmodelOrders().formattedDate(order.orderDeliveryDate),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 26,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                          "${order.userId.name} ${order.userId.fatherSurname} ${order.userId.motherSurname ?? ""}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold)),
                      Container(
                        margin: const EdgeInsets.only(
                            right: 12, top: 0, bottom: 10),
                        width: 80,
                        height: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              order.totalProduct.toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 34),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: const Text("Productos",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
