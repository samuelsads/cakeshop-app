import 'package:bloc/bloc.dart';
import 'package:cakeshopapp/domain/entities/client.dart';
import 'package:cakeshopapp/domain/entities/save.dart';
import 'package:cakeshopapp/domain/repositories/client_repository.dart';
import 'package:equatable/equatable.dart';

part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final ClientRepository clientRepository;
  ClientBloc(this.clientRepository) : super(const ClientState()) {
    on<SearchClientEvent>(
      (event, emit) => emit(state.copyWith(
          search: event.search, searchStatus: event.searchStatus)),
    );

    on<AllClientsEvent>(
      (event, emit) =>
          emit(state.copyWith(client: event.client, status: event.status)),
    );
  }

  Future<Save> saveClient(Map<String, dynamic> data, bool update) async {
    Save response;
    if (update) {
      //update
      response = await clientRepository.update(data);
    } else {
      response = await clientRepository.save(data);
    }

    if (response.success) {
      allClient(0, 10);
    }
    return response;
  }

  Future<void> allClient(int start, int limit) async {
    add(const AllClientsEvent(status: ClientStatus.loading));
    final data = await clientRepository.getAll(start, limit);
    add(AllClientsEvent(status: ClientStatus.success, client: data));
  }

  Future<void> cleanSearchClient() async {
    add(const SearchClientEvent(
        searchStatus: SearchStatus.initial, search: []));
  }

  Future<void> searchClient(String search) async {
    add(const SearchClientEvent(searchStatus: SearchStatus.loading));
    final data = await clientRepository.searchClient(search);
    add(SearchClientEvent(search: data, searchStatus: SearchStatus.success));
  }
}
