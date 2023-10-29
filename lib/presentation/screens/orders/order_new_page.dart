import 'package:cakeshopapp/config/theme/boxdecoration_custom.dart';
import 'package:cakeshopapp/config/theme/custom_styles.dart';
import 'package:cakeshopapp/domain/entities/client.dart';
import 'package:cakeshopapp/domain/entities/order.dart';
import 'package:cakeshopapp/domain/entities/payment.dart';
import 'package:cakeshopapp/presentation/blocs/payment_bloc/payment_bloc.dart';
import 'package:cakeshopapp/presentation/delegates/search_client_delegate.dart';
import 'package:cakeshopapp/presentation/providers/color_provider.dart';
import 'package:cakeshopapp/presentation/viewmodels/viewmodel_orders.dart';
import 'package:cakeshopapp/presentation/viewmodels/viewmodel_payment.dart';
import 'package:cakeshopapp/presentation/widgets/global/custom_text_form_field.dart';
import 'package:cakeshopapp/presentation/widgets/loader_widget.dart';
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
                    style: CustomStyles.text20W500(context
                        .select((ColorProvider value) => value.textColor)),
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
                          waitingToFinish(context);

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
