import 'package:cakeshopapp/config/theme/custom_styles.dart';
import 'package:cakeshopapp/config/theme/margins.dart';
import 'package:cakeshopapp/domain/entities/client.dart';
import 'package:cakeshopapp/presentation/blocs/client_bloc/client_bloc.dart';
import 'package:cakeshopapp/presentation/delegates/search_client_delegate.dart';
import 'package:cakeshopapp/presentation/providers/client_provider.dart';
import 'package:cakeshopapp/presentation/providers/color_provider.dart';
import 'package:cakeshopapp/presentation/screens/clients/client_details_page.dart';
import 'package:cakeshopapp/presentation/screens/clients/client_new_page.dart';
import 'package:cakeshopapp/presentation/viewmodels/viewmodel_client.dart';
import 'package:cakeshopapp/presentation/viewmodels/viewmodel_orders.dart';
import 'package:cakeshopapp/presentation/widgets/global/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({super.key});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

late ScrollController scrollController;

class _ClientPageState extends State<ClientPage>
    with AutomaticKeepAliveClientMixin {
  void scrollDownOrUp() {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      context.read<ClientProvider>().downOrUp = false;
    } else if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      context.read<ClientProvider>().downOrUp = true;
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()..addListener(scrollDownOrUp);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        ViewmodelClient()
            .getAllClients(0, 10, BlocProvider.of<ClientBloc>(context));
      }
    });
  }

  void _showSearch() async {
    final data =
        await showSearch(context: context, delegate: SearchClientDelegate());
    if (data != null) {
      if (mounted) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ClientDetailsPage(
                      client: data,
                    )));
      }
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollDownOrUp);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: (context.select((ClientProvider value) => value.downOrUp))
              ? 0
              : 1,
          child: (context.select((ClientProvider value) => value.downOrUp))
              ? const SizedBox.shrink()
              : Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: FloatingActionButton.extended(
                      heroTag: "btn-client",
                      backgroundColor: context
                          .select((ColorProvider value) => value.buttonColor),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ClienteNewPage())),
                      label: Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: context.select(
                                (ColorProvider value) => value.textButtonColor),
                          ),
                          Text(
                            "Agregar cliente",
                            style: TextStyle(
                                color: context.select((ColorProvider value) =>
                                    value.textButtonColor)),
                          ),
                        ],
                      )),
                ),
        ),
        body: BlocBuilder<ClientBloc, ClientState>(
          builder: (context, state) {
            if (state.clientLoading || state.clientInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.clientSuccess) {
              final data = state.client ?? [];
              if (data.isEmpty) {
                return SafeArea(
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: Margins.MARGIN_LEFT, right: Margins.MARING_RIGHT),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No cuenta con clientes",
                          textAlign: TextAlign.center,
                          style: CustomStyles.dontHaveResult(context.select(
                              (ColorProvider value) => value.buttonColor)),
                        )
                      ],
                    )),
                  ),
                );
              }

              return SafeArea(
                child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 24),
                        child: Text(
                          "Mis clientes",
                          style: CustomStyles.text20W500(context.select(
                              (ColorProvider value) => value.textColor)),
                        )),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: CustomTextFormField(
                          controller: TextEditingController(),
                          title: "",
                          hint: "Buscar cliente",
                          enabled: false,
                          leftMargin: Margins.MARGIN_LEFT,
                          rightMargin: Margins.MARING_RIGHT,
                          width: MediaQuery.of(context).size.width,
                          onTap: _showSearch),
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final client = data[index];
                          return _ItemClient(client: client);
                        },
                      ),
                    ),
                  ],
                ),
              );
            }

            return Container();
          },
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class _ItemClient extends StatelessWidget {
  const _ItemClient({required this.client});
  final Client client;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ClientProvider>().isLoading = false;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ClientDetailsPage(client: client)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        padding: const EdgeInsets.symmetric(vertical: 8),
        margin: const EdgeInsets.only(
            left: Margins.MARGIN_LEFT, right: Margins.MARING_RIGHT, top: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.shade100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.only(
                    left: Margins.MARGIN_LEFT, right: Margins.MARING_RIGHT),
                child: Text(
                  "${client.name} ${client.fatherSurname} ${client.motherSurname}",
                  style: CustomStyles.text14W400(
                      context.select((ColorProvider value) => value.textColor)),
                )),
            Container(
                margin: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Registrado desde el: ",
                      style: CustomStyles.text12W500(context
                          .select((ColorProvider value) => value.textColor)),
                    ),
                    Text(
                      ViewmodelOrders().formattedDate(client.createdAt),
                      style: CustomStyles.text12W500(context.select(
                          (ColorProvider value) => value.textDateColor)),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
