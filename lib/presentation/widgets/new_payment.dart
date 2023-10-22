import 'package:cakeshopapp/domain/entities/order.dart';
import 'package:cakeshopapp/domain/entities/payment.dart';
import 'package:cakeshopapp/presentation/blocs/payment_bloc/payment_bloc.dart';
import 'package:cakeshopapp/presentation/screens/orders/order_new_page.dart';
import 'package:cakeshopapp/presentation/viewmodels/viewmodel_orders.dart';
import 'package:cakeshopapp/presentation/viewmodels/viewmodel_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

const List<String> list = <String>['Efectivo', 'Tarjeta'];

class NewPayment extends StatefulWidget {
  const NewPayment(
      {super.key,
      required this.order,
      required this.update,
      required this.advancedPaymentController});

  final Order order;
  final bool update;
  final TextEditingController advancedPaymentController;

  @override
  State<NewPayment> createState() => NewPaymentState();
}

class NewPaymentState extends State<NewPayment> {
  @override
  void initState() {
    super.initState();
    payment = Payment(
      payment: 0,
      paymentType: 1,
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        ToastContext().init(context);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String dropdownValue = list.first;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFormField(
            controller: widget.advancedPaymentController,
            title: "Pago",
            hint: "0.00",
            leftMargin: 24,
            rightMargin: 24,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Text("Tipo de pago")),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButton(
                      value: dropdownValue,
                      elevation: 16,
                      isExpanded: true,
                      style: const TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Colors.transparent,
                      ),
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                          int position = list.indexOf(dropdownValue);
                          payment.paymentType = position + 1;
                        });
                      }),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                  ),
                  height: 45,
                  child: ElevatedButton(
                      onPressed: () async {
                        payment.payment =
                            double.parse(widget.advancedPaymentController.text);
                        if (widget.update) {
                          payment.orderId = widget.order.uid;

                          Map<String, dynamic> dataPayment = {
                            "payment": payment.payment,
                            "payment_type": payment.paymentType,
                            "order_id": payment.orderId
                          };
                          final responsePayment = await ViewmodelPayment()
                              .saveOrder(dataPayment,
                                  BlocProvider.of<PaymentBloc>(context), false);
                          print(responsePayment);

                          if (!responsePayment.success) {
                            Toast.show(responsePayment.msg,
                                duration: Toast.lengthLong,
                                gravity: Toast.bottom);
                            return;
                          }

                          Map<String, dynamic> data = {
                            "uid": widget.order.uid,
                            "client_id": widget.order.clientId,
                            "price": widget.order.price,
                            "description": widget.order.description,
                            "order_delivery_date":
                                widget.order.orderDeliveryDate.toString(),
                            "discount": widget.order.discount,
                            "additional_things": widget.order.additionalThings,
                            "paid": widget.order.paid,
                            "delivered": widget.order.delivered,
                            "advance_payment": widget.order.advancePayment,
                            "advance_payment_type": 1,
                            "total_products": widget.order.totalProduct,
                          };

                          final response = await ViewmodelOrders()
                              .saveOrder(data, BlocProvider.of(context), true);

                          Navigator.popUntil(context, (route) => route.isFirst);
                        } else {
                          savePaymentNextSaveOrder = true;
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: const Color(0xff0073E1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.save),
                          Text("Guardar pago")
                        ],
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
