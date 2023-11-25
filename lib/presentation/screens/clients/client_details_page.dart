import 'package:cakeshopapp/config/theme/boxdecoration_custom.dart';
import 'package:cakeshopapp/config/theme/custom_styles.dart';
import 'package:cakeshopapp/config/theme/margins.dart';
import 'package:cakeshopapp/domain/entities/client.dart';
import 'package:cakeshopapp/domain/entities/cliente_details.dart';
import 'package:cakeshopapp/presentation/blocs/client_bloc/client_bloc.dart';
import 'package:cakeshopapp/presentation/providers/client_provider.dart';
import 'package:cakeshopapp/presentation/providers/color_provider.dart';
import 'package:cakeshopapp/presentation/screens/clients/client_new_page.dart';
import 'package:cakeshopapp/presentation/viewmodels/viewmodel_client.dart';
import 'package:cakeshopapp/presentation/widgets/global/orders_slideshow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';

class ClientDetailsPage extends StatefulWidget {
  ClientDetailsPage({required this.client, super.key});

  final Client client;
  late List<ClientDetails> details = [];
  @override
  State<ClientDetailsPage> createState() => _ClientDetailsPageState();
}

class _ClientDetailsPageState extends State<ClientDetailsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      widget.details = await ViewmodelClient().clientDetails(
          widget.client.uid, BlocProvider.of<ClientBloc>(context));
      ViewmodelClient().totalClient(widget.details);
      if (mounted) context.read<ClientProvider>().isLoading = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxdecorationCustom.customBoxdecoration(context),
        child: (!context.select((ClientProvider value) => value.isLoading))
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  (widget.details.isEmpty)
                      ? Center(
                          child: Text(
                            "No cuenta con información para mostrar",
                            textAlign: TextAlign.center,
                            style: CustomStyles.text20W500(context.select(
                                (ColorProvider value) => value.textColor)),
                          ),
                        )
                      : SafeArea(
                          child: Container(
                            margin: const EdgeInsets.only(
                              top: 24,
                            ),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            color: Colors.transparent,
                            child: Column(
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(
                                        top: 24,
                                        left: Margins.MARGIN_LEFT,
                                        right: Margins.MARING_RIGHT),
                                    child: Text(
                                      widget.details.length.toString(),
                                      style: CustomStyles.text24W800(context
                                          .select((ColorProvider value) =>
                                              value.textColor)),
                                    )),
                                Container(
                                    margin: const EdgeInsets.only(
                                        top: 8,
                                        left: Margins.MARGIN_LEFT,
                                        right: Margins.MARING_RIGHT),
                                    child: Text(
                                      "Pedidos realizados",
                                      style: CustomStyles.text12W500(context
                                          .select((ColorProvider value) =>
                                              value.textColor)),
                                    )),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 8,
                                      left: Margins.MARGIN_LEFT,
                                      right: Margins.MARING_RIGHT),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white),
                                  child: Text(
                                      "Total ${NumberFormat.currency(symbol: '\$', decimalDigits: 2, locale: 'es_MX').format(ViewmodelClient().totalClient(widget.details))}",
                                      style: CustomStyles.text12W500(context
                                          .select((ColorProvider value) =>
                                              value.textColor))),
                                ),
                                _PieChart(widget.details),
                                OrdersSlideshow(data: widget.details)
                              ],
                            ),
                          ),
                        ),
                  SafeArea(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          top: 24,
                          left: Margins.MARGIN_LEFT,
                          right: Margins.MARING_RIGHT),
                      child: Row(
                        children: [
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
                          const Spacer(),
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ClienteNewPage(
                                          clientUpd: widget.client,
                                          update: true,
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
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _PieChart(List<ClientDetails> data) {
    Map<String, double> dataMap = {
      "Pagado": ViewmodelClient().totalPaymentClient(data),
      "Deuda": ViewmodelClient().debtPaymentClient(data),
    };

    return Container(
        margin: const EdgeInsets.only(top: 12),
        width: double.infinity,
        height: 150,
        child: PieChart(
          dataMap: dataMap,
          baseChartColor: Colors.grey[50]!.withOpacity(0.15),
        ));
  }
}
