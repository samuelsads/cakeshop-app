import 'package:cakeshopapp/config/theme/custom_styles.dart';
import 'package:cakeshopapp/config/theme/margins.dart';
import 'package:cakeshopapp/presentation/blocs/order_bloc/order_bloc.dart';
import 'package:cakeshopapp/presentation/viewmodels/viewmodel_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoneOrderWidget extends StatefulWidget {
  const DoneOrderWidget({required this.uuid, super.key});

  final String uuid;

  @override
  State<DoneOrderWidget> createState() => _DoneOrderWidgetState();
}

class _DoneOrderWidgetState extends State<DoneOrderWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(top: 40),
            child: Text(
              "Finalizar Pedido",
              style: CustomStyles.titleStyle(),
            )),
        Container(
            margin: const EdgeInsets.only(
                top: 20,
                left: Margins.MARGIN_LEFT,
                right: Margins.MARING_RIGHT),
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
                onPressed: () async {
                  final data = await ViewmodelOrders().updateOrderDelivered(
                      widget.uuid, BlocProvider.of<OrderBloc>(context));
                  print(data.msg);
                },
                child: const Text("Finalizar"))),
        Container(
            margin: const EdgeInsets.only(
                top: 8, left: Margins.MARGIN_LEFT, right: Margins.MARING_RIGHT),
            child: Text(
              "Al dar clic en finalizar pedido, este desaparecera de la lista principal  y no podra visualizarlo de nuevo, tenga en cuenta esto antes de finalizar el pedido.",
              textAlign: TextAlign.justify,
              style: CustomStyles.descriptionStyle(),
            ))
      ],
    );
  }
}
