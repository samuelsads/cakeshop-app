import 'package:cakeshopapp/config/theme/boxdecoration_custom.dart';
import 'package:cakeshopapp/domain/entities/client.dart';
import 'package:cakeshopapp/domain/entities/order.dart';
import 'package:cakeshopapp/presentation/delegates/search_client_delegate.dart';
import 'package:cakeshopapp/presentation/viewmodels/viewmodel_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class OrderNewPage extends StatefulWidget {
  const OrderNewPage({this.id, Key? key}) : super(key: key);

  final String? id;

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
late Client client;
late Order order;

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

    priceController = TextEditingController();
    discountController = TextEditingController();
    advancedPaymentController = TextEditingController();
    numberOfProductController = TextEditingController();
    dateDeliveryController = TextEditingController();
    otherThingsController = TextEditingController();
    descriptionController = TextEditingController();
    clientController = TextEditingController();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxdecorationCustom.customBoxdecoration(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
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
                child: const Text(
                  "Agregar orden",
                  style: TextStyle(
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
                        controller: advancedPaymentController,
                        title: "Abono",
                        hint: "0.00",
                        leftMargin: 4,
                        rightMargin: 24,
                        width: 90),
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
                    onPressed: () {
                      if (priceController.text.isNotEmpty &&
                          numberOfProductController.text.isNotEmpty &&
                          dateDeliveryController.text.isNotEmpty &&
                          descriptionController.text.isNotEmpty) {
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
                          "advance_payment":
                              (advancedPaymentController.text.isEmpty)
                                  ? 0.0
                                  : advancedPaymentController.text,
                          "advance_payment_type": 1,
                          "total_products": numberOfProductController.text
                        };

                        final response = ViewmodelOrders()
                            .saveOrder(data, BlocProvider.of(context));
                      } else {
                        print("Datos incompletos");
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
                        Text("Guardar pedido")
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    required this.hint,
    required this.leftMargin,
    required this.rightMargin,
    required this.width,
    required this.controller,
    required this.title,
    this.onTap = null,
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
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
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
