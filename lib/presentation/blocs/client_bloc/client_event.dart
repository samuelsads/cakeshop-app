part of 'client_bloc.dart';

abstract class ClientEvent extends Equatable {
  const ClientEvent();

  @override
  List<Object> get props => [];
}

class AllClientsEvent extends ClientEvent {
  final List<Client>? client;
  final ClientStatus? status;

  const AllClientsEvent({this.client, this.status = ClientStatus.initial});
}

class SearchClientEvent extends ClientEvent {
  final List<Client>? search;
  final SearchStatus searchStatus;

  const SearchClientEvent(
      {this.search, this.searchStatus = SearchStatus.initial});
}
