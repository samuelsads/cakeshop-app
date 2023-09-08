import 'package:bloc/bloc.dart';
import 'package:cakeshopapp/domain/entities/client.dart';
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
  }

  Future<void> cleanSearchClient() async {
    add(SearchClientEvent(searchStatus: SearchStatus.initial, search: []));
  }

  Future<void> searchClient(String search) async {
    add(const SearchClientEvent(searchStatus: SearchStatus.loading));
    final data = await clientRepository.searchClient(search);
    add(SearchClientEvent(search: data, searchStatus: SearchStatus.success));
  }
}
