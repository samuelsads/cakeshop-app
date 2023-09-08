import 'package:cakeshopapp/domain/datasources/client_datasource.dart';
import 'package:cakeshopapp/domain/entities/client.dart';
import 'package:cakeshopapp/domain/repositories/client_repository.dart';

class ClientRepositoryImpl extends ClientRepository {
  final ClientDataSource dataSource;

  ClientRepositoryImpl({required this.dataSource});
  @override
  Future<List<Client>> searchClient(String search) async {
    return await dataSource.searchClient(search);
  }
}
