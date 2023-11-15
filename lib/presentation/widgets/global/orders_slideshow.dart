import 'package:cakeshopapp/config/theme/custom_styles.dart';
import 'package:cakeshopapp/config/theme/margins.dart';
import 'package:cakeshopapp/domain/entities/cliente_details.dart';
import 'package:cakeshopapp/domain/entities/order.dart';
import 'package:cakeshopapp/domain/entities/payment.dart';
import 'package:cakeshopapp/presentation/providers/color_provider.dart';
import 'package:cakeshopapp/presentation/screens/payments/payments_by_order_page.dart';
import 'package:cakeshopapp/presentation/viewmodels/viewmodel_orders.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrdersSlideshow extends StatelessWidget {
  const OrdersSlideshow({required this.data, super.key});
  final List<ClientDetails> data;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Swiper(
        itemCount: data.length,
        viewportFraction: 0.8,
        duration: 2000,
        scale: 0.9,
        autoplay: true,
        itemBuilder: (context, index) => _Slide(
            order: data[index].order,
            totalPayments: data[index].payments.length,
            payments: data[index].payments),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  const _Slide(
      {required this.payments,
      required this.totalPayments,
      required this.order});
  final Order order;
  final int totalPayments;
  final List<Payment> payments;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black87, blurRadius: 2, offset: Offset(0, 10))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 24),
                    child: Text(
                      ViewmodelOrders().formattedDate(order.orderDeliveryDate),
                      style: CustomStyles.text12W500(context
                          .select((ColorProvider value) => value.textColor1)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 2),
                    child: Text(
                      "Fecha de entrega",
                      style: CustomStyles.text10W500(context
                          .select((ColorProvider value) => value.textColor1)),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 24),
                      child: Text(
                        (order.paid)
                            ? "Si"
                            : (totalPayments > 0)
                                ? "Parcialmente"
                                : "No",
                        style: CustomStyles.text12W500(context
                            .select((ColorProvider value) => value.textColor1)),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      child: Text(
                        "Pagado",
                        style: CustomStyles.text10W500(context
                            .select((ColorProvider value) => value.textColor1)),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 24),
                        child: Text(
                          (order.delivered) ? "Si" : "No",
                          style: CustomStyles.text12W500(context.select(
                              (ColorProvider value) => value.textColor1)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 2),
                        child: Text(
                          "Entregado",
                          style: CustomStyles.text10W500(context.select(
                              (ColorProvider value) => value.textColor1)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 8,
                      left: Margins.MARGIN_LEFT,
                      right: Margins.MARING_RIGHT),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white),
                  child: Text(
                      "Total ${NumberFormat.currency(symbol: '\$', decimalDigits: 2, locale: 'es_MX').format(order.price)}",
                      style: CustomStyles.text12W500(context
                          .select((ColorProvider value) => value.textColor))),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 8),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        top: 8,
                        left: Margins.MARGIN_LEFT,
                        right: Margins.MARING_RIGHT),
                    child: Text(
                      order.description,
                      maxLines: 3,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                      style: CustomStyles.text12W500(context
                          .select((ColorProvider value) => value.textColor1)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 2),
                    child: Text(
                      "Descripción",
                      style: CustomStyles.text10W500(context
                          .select((ColorProvider value) => value.textColor1)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: Margins.MARGIN_LEFT, right: Margins.MARING_RIGHT),
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: (totalPayments == 0)
                      ? () {}
                      : () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PaymentsByOrderPage(payments: payments))),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.wallet,
                          color: context.select(
                              (ColorProvider value) => value.textButtonColor)),
                      Text(
                        (totalPayments == 0) ? "Sin pagos " : "Ver pagos",
                        style: TextStyle(
                            color: context.select(
                                (ColorProvider value) => value.textColor)),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
