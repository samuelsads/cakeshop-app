import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cakeshopapp/config/theme/boxdecoration_custom.dart';
import 'package:cakeshopapp/domain/entities/client.dart';
import 'package:cakeshopapp/presentation/blocs/client_bloc/client_bloc.dart';
import 'package:cakeshopapp/presentation/providers/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchClientDelegate extends SearchDelegate<Client?> {
  Timer? timer;

  @override
  String get searchFieldLabel => 'Buscar cliente';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      FadeIn(
          animate: query.isNotEmpty,
          child: IconButton(
              onPressed: () => query = '', icon: const Icon(Icons.clear)))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          BlocProvider.of<ClientBloc>(context).cleanSearchClient();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("buildResults");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final bloc = BlocProvider.of<ClientBloc>(context);

    timer?.cancel();
    timer = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        bloc.searchClient(query);
      }
    });

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      decoration: BoxdecorationCustom.customBoxdecoration(context),
      child: BlocBuilder<ClientBloc, ClientState>(
        builder: (context, state) {
          if (state.searchLoading) {
            return Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: BoxdecorationCustom.customBoxdecoration(context),
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CircularProgressIndicator(),
                    Text("Buscando información...",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: context.select(
                                (ColorProvider value) => value.buttonColor)))
                  ],
                )));
          } else if (state.searchSuccess) {
            List<Client> search = (state.search ?? []);
            return (search.isNotEmpty)
                ? ListView.builder(
                    itemCount: search.length,
                    itemBuilder: (context, index) {
                      final data = search[index];
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              bloc.cleanSearchClient();
                              close(context, data);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 1),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: ListTile(
                                title: Text(
                                    "${data.name} ${data.fatherSurname} ${data.motherSurname}"),
                              ),
                            ),
                          ),
                          Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.grey)
                        ],
                      );
                    },
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    child: Center(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off,
                            size: 38,
                            color: context.select(
                                (ColorProvider value) => value.buttonColor)),
                        Text(
                          "No se encontraron resultados para la busqueda $query",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: context.select(
                                  (ColorProvider value) => value.buttonColor)),
                        ),
                      ],
                    )),
                  );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
