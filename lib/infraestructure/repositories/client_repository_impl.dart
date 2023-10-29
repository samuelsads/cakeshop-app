import 'package:cakeshopapp/domain/datasources/client_datasource.dart';
import 'package:cakeshopapp/domain/entities/client.dart';
import 'package:cakeshopapp/domain/entities/save.dart';
import 'package:cakeshopapp/domain/repositories/client_repository.dart';

class ClientRepositoryImpl extends ClientRepository {
  final ClientDataSource dataSource;

  ClientRepositoryImpl({required this.dataSource});
  @override
  Future<List<Client>> searchClient(String search) async {
    return await dataSource.searchClient(search);
  }

  @override
  Future<List<Client>> getAll(int start, int limit) async {
    return await dataSource.getAll(start, limit);
  }

  @override
  Future<Save> save(Map<String, dynamic> data) async =>
      await dataSource.save(data);
}
