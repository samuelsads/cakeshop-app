import 'package:cakeshopapp/domain/entities/order.dart';
import 'package:cakeshopapp/presentation/blocs/payment_bloc/payment_bloc.dart';
import 'package:cakeshopapp/presentation/screens/orders/order_new_page.dart';
import 'package:cakeshopapp/presentation/viewmodels/viewmodel_orders.dart';
import 'package:cakeshopapp/presentation/viewmodels/viewmodel_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HistoryOfPayment extends StatefulWidget {
  const HistoryOfPayment({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  State<HistoryOfPayment> createState() => HistoryOfPaymentState();
}

class HistoryOfPaymentState extends State<HistoryOfPayment> {
  @override
  Widget build(BuildContext context) {
    double total = 0.0;
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        if (state.paymentSuccess) {
          final data = state.payment ?? [];
          return ListView.builder(
            itemCount: data.length + 1,
            itemBuilder: (context, index) {
              if (index == data.length) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(
                                left: 24, right: 24, top: 10),
                            child: const Text("Total")),
                        Container(
                            margin: const EdgeInsets.only(
                                left: 24, right: 24, top: 10),
                            child: Text(NumberFormat.currency(
                                    symbol: '\$',
                                    decimalDigits: 2,
                                    locale: 'es_MX')
                                .format(widget.order.price))),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(
                                left: 24, right: 24, top: 10),
                            child: const Text("Pendiente")),
                        Container(
                            margin: const EdgeInsets.only(
                                left: 24, right: 24, top: 10),
                            child: Text(NumberFormat.currency(
                                    symbol: '\$',
                                    decimalDigits: 2,
                                    locale: 'es_MX')
                                .format(
                                    widget.order.price - total))),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(
                                left: 24, right: 24, top: 10),
                            child: const Text("Pagado")),
                        Container(
                            margin: const EdgeInsets.only(
                                left: 24, right: 24, top: 10),
                            child: Text(NumberFormat.currency(
                                    symbol: '\$',
                                    decimalDigits: 2,
                                    locale: 'es_MX')
                                .format(total))),
                      ],
                    ),
                  ],
                );
              }

              final payment = data[index];
              total += data[index].payment;

              return Container(
                margin: const EdgeInsets.only(left: 24, right: 24, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 4),
                          child: Text(
                            ViewmodelOrders().formattedDate(
                                payment.createdAt ?? DateTime.now()),
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 4, left: 4),
                          child: Text(
                            ViewmodelPayment().typePayment(payment.paymentType),
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 4),
                          child: Text(
                            NumberFormat.currency(
                                    symbol: '\$',
                                    decimalDigits: 2,
                                    locale: 'es_MX')
                                .format(payment.payment),
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 4),
                            child: const Text(
                              "Cobró: ",
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 4),
                            child: Text(
                                "${payment.user!.name} ${payment.user!.fatherSurname} ${payment.user?.motherSurname ?? ''}",
                                style: const TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      width: double.infinity,
                      height: 2,
                      color: Colors.grey,
                    )
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(child: Text("Aun no se realizan pagos"));
        }
      },
    );
  }
}
