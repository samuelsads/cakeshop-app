part of 'client_bloc.dart';

abstract class ClientEvent extends Equatable {
  const ClientEvent();

  @override
  List<Object> get props => [];
}

class SearchClientEvent extends ClientEvent {
  final List<Client>? search;
  final SearchStatus searchStatus;

  const SearchClientEvent(
      {this.search, this.searchStatus = SearchStatus.initial});
}
