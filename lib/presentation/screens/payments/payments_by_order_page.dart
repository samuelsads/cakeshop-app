import 'package:cakeshopapp/config/theme/boxdecoration_custom.dart';
import 'package:cakeshopapp/config/theme/custom_styles.dart';
import 'package:cakeshopapp/config/theme/margins.dart';
import 'package:cakeshopapp/domain/entities/payment.dart';
import 'package:cakeshopapp/presentation/providers/client_provider.dart';
import 'package:cakeshopapp/presentation/providers/color_provider.dart';
import 'package:cakeshopapp/presentation/viewmodels/viewmodel_orders.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PaymentsByOrderPage extends StatelessWidget {
  const PaymentsByOrderPage({required this.payments, super.key});

  final List<Payment> payments;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxdecorationCustom.customBoxdecoration(context),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 74,
              ),
              margin: const EdgeInsets.only(
                  left: Margins.MARGIN_LEFT, right: Margins.MARING_RIGHT),
              child: ListView.builder(
                itemCount: payments.length,
                itemBuilder: (context, index) {
                  return _ItemPaymentByOrder(payments: payments[index]);
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              margin: const EdgeInsets.only(
                  top: 24,
                  left: Margins.MARGIN_LEFT,
                  right: Margins.MARING_RIGHT),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      "PAGOS",
                      style: CustomStyles.text20W500(context
                          .select((ColorProvider value) => value.textColor)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<ClientProvider>().isLoading = true;
                      Navigator.pop(context);
                    },
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemPaymentByOrder extends StatelessWidget {
  const _ItemPaymentByOrder({
    required this.payments,
  });

  final Payment payments;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(24)),
        child: Column(
          children: [
            Container(
              margin:
                  const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
              child: Text(
                  "Total pagado: ${NumberFormat.currency(symbol: '\$', decimalDigits: 2, locale: 'es_MX').format(payments.payment)}",
                  style: CustomStyles.text14W400(context
                      .select((ColorProvider value) => value.textColor))),
            ),
            Container(
              margin:
                  const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
              child: Text(
                (payments.paymentType == 1)
                    ? "Forma de pago: Efectivo"
                    : "Forma de pago: Tarjeta",
                style: CustomStyles.text14W400(
                    context.select((ColorProvider value) => value.textColor)),
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
              child: Text(
                "Pago realizado el: ${ViewmodelOrders().formattedDate(payments.createdAt ?? DateTime.now())}",
                style: CustomStyles.text10W500(
                    context.select((ColorProvider value) => value.textColor)),
              ),
            ),
          ],
        ));
  }
}
