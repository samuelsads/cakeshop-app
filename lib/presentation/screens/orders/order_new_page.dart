import 'package:cakeshopapp/config/theme/boxdecoration_custom.dart';
import 'package:cakeshopapp/domain/entities/client.dart';
import 'package:cakeshopapp/domain/entities/order.dart';
import 'package:cakeshopapp/domain/entities/payment.dart';
import 'package:cakeshopapp/presentation/blocs/payment_bloc/payment_bloc.dart';
import 'package:cakeshopapp/presentation/delegates/search_client_delegate.dart';
import 'package:cakeshopapp/presentation/providers/color_provider.dart';
import 'package:cakeshopapp/presentation/viewmodels/viewmodel_loading.dart';
import 'package:cakeshopapp/presentation/viewmodels/viewmodel_orders.dart';
import 'package:cakeshopapp/presentation/viewmodels/viewmodel_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

bool savePaymentNextSaveOrder = false;
late Payment payment;

class OrderNewPage extends StatefulWidget {
  const OrderNewPage({this.update = false, this.orderUpd, Key? key})
      : super(key: key);

  final bool? update;
  final Order? orderUpd;

  @override
  State<OrderNewPage> createState() => _OrderNewPageState();
}

late TextEditingController priceController;
late TextEditingController discountController;
late TextEditingController advancedPaymentController;
late TextEditingController numberOfProductController;
late TextEditingController dateDeliveryController;
late TextEditingController otherThingsController;
late TextEditingController descriptionController;
late TextEditingController clientController;
late TextEditingController advancedPayment;
late Client client;

class _OrderNewPageState extends State<OrderNewPage> {
  void _dateModal() async {
    DateTime? newBirthday = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: const Color(0xFF8CE7F1),
                colorScheme:
                    const ColorScheme.light(primary: Color(0xFF0073E1)),
                buttonTheme:
                    const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!);
        });

    dateDeliveryController.text =
        DateFormat('yyyy/MM/dd').format(newBirthday ?? DateTime.now());
  }

  void _showSearch() async {
    final data =
        await showSearch(context: context, delegate: SearchClientDelegate());
    if (data != null) {
      client = data;
      clientController.text =
          "${data.name} ${data.fatherSurname} ${data.motherSurname}";
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        ToastContext().init(context);
        if (widget.update!) {
          ViewmodelPayment().getAll(
              widget.orderUpd!.uid, BlocProvider.of<PaymentBloc>(context));
        }
      }
    });

    priceController = TextEditingController();
    discountController = TextEditingController();
    advancedPaymentController = TextEditingController();
    numberOfProductController = TextEditingController();
    dateDeliveryController = TextEditingController();
    otherThingsController = TextEditingController();
    descriptionController = TextEditingController();
    clientController = TextEditingController();
    advancedPayment = TextEditingController();

    editOrder();
  }

  void editOrder() {
    if (widget.update!) {
      priceController.text = (widget.orderUpd?.price ?? 0).toString();
      discountController.text = (widget.orderUpd?.discount ?? 0).toString();
      advancedPayment.text = (widget.orderUpd?.advancePayment ?? 0).toString();
      numberOfProductController.text =
          (widget.orderUpd?.totalProduct ?? 0).toString();
      dateDeliveryController.text = DateFormat('yyyy/MM/dd')
          .format(widget.orderUpd?.orderDeliveryDate ?? DateTime.now());
      otherThingsController.text =
          (widget.orderUpd?.additionalThings ?? "").toString();
      descriptionController.text = (widget.orderUpd?.description ?? "");
      clientController.text =
          "${widget.orderUpd!.clientId!.name} ${widget.orderUpd!.clientId!.fatherSurname} ${widget.orderUpd!.clientId?.motherSurname ?? ''}";
      client = widget.orderUpd!.clientId!;
    }
  }

  @override
  void dispose() {
    priceController.dispose();
    discountController.dispose();
    advancedPaymentController.dispose();
    numberOfProductController.dispose();
    dateDeliveryController.dispose();
    otherThingsController.dispose();
    descriptionController.dispose();
    clientController.dispose();
    advancedPayment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxdecorationCustom.customBoxdecoration(context),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 24, top: 12),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                            height: 50,
                            color: Colors.transparent,
                            child: const Icon(Icons.arrow_back)),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 0),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    "Agregar orden",
                    style: TextStyle(
                      color: context
                          .select((ColorProvider value) => value.buttonColor),
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextFormField(
                          controller: clientController,
                          title: "Cliente",
                          hint: "Buscar cliente",
                          enabled: false,
                          leftMargin: 24,
                          rightMargin: 24,
                          width: MediaQuery.of(context).size.width * 0.84,
                          onTap: _showSearch),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomTextFormField(
                          controller: priceController,
                          title: "Precio",
                          hint: "0.00",
                          leftMargin: 24,
                          rightMargin: 4,
                          width: 90),
                      CustomTextFormField(
                          controller: discountController,
                          title: "Descuento",
                          hint: "0.00",
                          leftMargin: 4,
                          rightMargin: 4,
                          width: 90),
                      CustomTextFormField(
                        controller: advancedPayment,
                        enabled: false,
                        title: "Abono",
                        hint: "0.00",
                        leftMargin: 4,
                        rightMargin: 24,
                        width: 90,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextFormField(
                          controller: numberOfProductController,
                          title: "Num. productos",
                          hint: "0.00",
                          leftMargin: 24,
                          rightMargin: 4,
                          width: 140),
                      CustomTextFormField(
                          controller: dateDeliveryController,
                          title: "Fec. de entrega",
                          hint: "2023/12/03",
                          leftMargin: 4,
                          rightMargin: 24,
                          textInput: TextInputType.datetime,
                          onTap: _dateModal,
                          enabled: false,
                          width: 140),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextFormField(
                          controller: otherThingsController,
                          title: "Adicionales",
                          hint: "Bases de madera, fuentes u otros objetos",
                          leftMargin: 24,
                          rightMargin: 24,
                          width: MediaQuery.of(context).size.width * 0.84),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextFormField(
                        controller: descriptionController,
                        title: "Descripción",
                        hint:
                            "Pastel grande de 2 pisos redondo de color azul, etc...",
                        leftMargin: 24,
                        rightMargin: 24,
                        width: MediaQuery.of(context).size.width * 0.84,
                        maxLines: 5,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 24, left: 24, right: 24),
                  height: 45,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (priceController.text.isNotEmpty &&
                            numberOfProductController.text.isNotEmpty &&
                            dateDeliveryController.text.isNotEmpty &&
                            descriptionController.text.isNotEmpty) {
                          ViewmodelLoading().waitingToFinishing(context);

                          Map<String, dynamic> data = {
                            "client_id": client.uid,
                            "price": priceController.text,
                            "description": descriptionController.text,
                            "order_delivery_date": dateDeliveryController.text,
                            "discount": (discountController.text.isEmpty)
                                ? "0.0"
                                : discountController.text,
                            "additional_things":
                                (otherThingsController.text.isEmpty)
                                    ? ""
                                    : otherThingsController.text,
                            "paid": false,
                            "delivered": false,
                            "advance_payment":
                                (advancedPaymentController.text.isEmpty &&
                                        !savePaymentNextSaveOrder)
                                    ? 0.0
                                    : advancedPaymentController.text,
                            "advance_payment_type": 1,
                            "total_products": numberOfProductController.text,
                          };

                          if (widget.update!) {
                            data["uid"] = widget.orderUpd!.uid;
                            data["delivered"] = widget.orderUpd!.delivered;
                          }

                          final response = await ViewmodelOrders().saveOrder(
                              data, BlocProvider.of(context), widget.update!);
                          await ViewmodelOrders().getAllOrders(
                              0, 10, false, BlocProvider.of(context));

                          if (savePaymentNextSaveOrder) {
                            payment.orderId = response.id;

                            Map<String, dynamic> dataPayment = {
                              "payment": payment.payment,
                              "payment_type": payment.paymentType,
                              "order_id": payment.orderId
                            };
                            await ViewmodelPayment().saveOrder(dataPayment,
                                BlocProvider.of<PaymentBloc>(context), false);
                            //GUARDAR el pago
                          }

                          Navigator.popUntil(context, (route) => route.isFirst);
                        } else {
                          print("Datos incompletos");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: context.select(
                              (ColorProvider value) => value.buttonColor),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.save,
                              color: context.select((ColorProvider value) =>
                                  value.textButtonColor)),
                          Text(
                            (widget.update!)
                                ? "Actualizar pedido"
                                : "Guardar pedido",
                            style: TextStyle(
                                color: context.select((ColorProvider value) =>
                                    value.textButtonColor)),
                          )
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.hint,
    required this.leftMargin,
    required this.rightMargin,
    required this.width,
    required this.controller,
    required this.title,
    this.onTap,
    this.maxLines = 1,
    this.enabled = true,
    this.textInput = TextInputType.number,
    super.key,
  });
  final String title;
  final String hint;
  final double leftMargin;
  final double rightMargin;
  final double width;
  final TextEditingController controller;
  final Function()? onTap;
  final TextInputType? textInput;
  final bool enabled;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: leftMargin, right: rightMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(left: 10, bottom: 4),
                width: width,
                child: Text(
                  title,
                  style: TextStyle(
                      color: context.select(
                          (ColorProvider value) => value.textButtonColor),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
            Container(
              width: width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: TextFormField(
                enabled: enabled,
                controller: controller,
                keyboardType: textInput,
                maxLines: maxLines,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(left: 10),
                    hintText: hint,
                    hintMaxLines: maxLines,
                    hintStyle: const TextStyle(fontSize: 14)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
