part of 'client_bloc.dart';

enum ClientStatus {
  initial,
  loading,
  success,
  error,
  done,
}

enum SearchStatus {
  initial,
  loading,
  success,
  error,
  done,
}

class ClientState extends Equatable {
  const ClientState(
      {this.client,
      this.status = ClientStatus.initial,
      this.search,
      this.searchStatus = SearchStatus.initial});

  final Client? client;
  final ClientStatus status;
  final List<Client>? search;
  final SearchStatus searchStatus;

  ClientState copyWith(
          {Client? client,
          ClientStatus? status,
          List<Client>? search,
          SearchStatus? searchStatus}) =>
      ClientState(
          client: client ?? this.client,
          status: status ?? this.status,
          search: search ?? this.search,
          searchStatus: searchStatus ?? this.searchStatus);

  @override
  List<Object?> get props => [client, status, search, searchStatus];

  @override
  String toString() {
    return 'Client: $client, Status: $status';
  }
}

extension ClientStateX on ClientState {
  bool get clientLoading => status == ClientStatus.loading;
  bool get clientInitial => status == ClientStatus.initial;
  bool get clientError => status == ClientStatus.error;
  bool get clientSuccess => status == ClientStatus.success;

  bool get searchLoading => searchStatus == SearchStatus.loading;
  bool get searchInitial => searchStatus == SearchStatus.initial;
  bool get searchtError => searchStatus == SearchStatus.error;
  bool get searchSuccess => searchStatus == SearchStatus.success;
}
